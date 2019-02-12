#!/bin/sh
#
#
usage () {
    cat <<EOF                                              
PASTIFY: a command line pastebin service helper
Usage:
   pastify <service> [file|stream]
Services:
   uguu.se, mixtape.moe, catbox.moe,
   dmca.gripe, rokket.space, pastebin.com
Environment variables for pastebin.com:
   PB_API_DEV: developer api key [required] https://pastebin.com/api#1
   PB_API_USR: user api key [optional] https://pastebin.com/api#8
   PRIVACY: paste visibility  [optional] valid values: public|0, unlisted|1, private|2
   ANON: paste w/o a user key even if defined [optional]
Examples:
   pastify pb ~/.vimrc
   pastify pb <(ps aux)
   dmesg | pastify iop
   PB_API_DEV=XXXX PRIVACY=0 pastify pb /tmp/leak.txt
EOF
  exit 0
}

ARG="${2:-/dev/stdin}"

case $1 in
	uguu|uguu.se|u*)
		curl -sF 'file=@-' https://uguu.se/api.php?d=upload-tool < $ARG
	;;
	mixtape|mixtape.moe|m*)
		curl -sF 'files[]=@-' https://mixtape.moe/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	catbox|catbox.moe|cat*)
		curl -sF 'reqtype=fileupload' -F 'fileToUpload=@-' https://catbox.moe/user/api.php < $ARG
	;;
	dmca|dmca.gripe|gripe|dm*)
		curl -sF 'files[]=@-' http://dmca.gripe/api/upload < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	rokket|rokket.space|r*)
		curl -sF 'files[]=@-' https://rokket.space/upload < $ARG | grep 'url' | sed 's/"url": "//;s/",//;s/ //g'
	;;
	pb|pastebin|pastebin.com)
		[ -z ${PB_API_DEV} ] && usage
		PRIVACY="${PRIVACY:-1}"
		if [ -n "${PRIVACY}" ]; then
			case ${PRIVACY} in
				public|0)
					PRIVACY=0
				;;
				unlisted|1)
					PRIVACY=1
				;;
				private|2)
					PRIVACY=2
				;;
				*)
					usage
				;;
			esac
		fi
		qs="api_option=paste&api_dev_key=${PB_API_DEV}&api_paste_expire_date=N&api_paste_private=${PRIVACY}&api_paste_name=`basename ${ARG}`"
		[ -n ${PB_API_USR} ] && [ -z ${ANON} ] && qs="${qs}&api_user_key=${PB_API_USR}"
		curl -d "${qs}" --data-urlencode "api_paste_code=`<$ARG`" http://pastebin.com/api/api_post.php
	;;
	*)
		usage
	;;
esac
# vi:syntax=sh