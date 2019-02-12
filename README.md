# Pastify - WIP
```                                                 
                       ,--.  ,--. ,---.          
 ,---.  ,--,--. ,---.,-'  '-.`--'/  .-',--. ,--. 
| .-. |' ,-.  |(  .-''-.  .-',--.|  `-, \  '  /  
| '-' '\ '-'  |.-'  `) |  |  |  ||  .-'  \   '   
|  |-'  `--`--'`----'  `--'  `--'`--'  .-'  /    
`--'                                   `---'     
```
A command line pastebin service helper

### Services

- [Uguu.se][uguu]
- [Mixtape.moe][mixtape]
- [Catbox.moe][catbox]
- [DMCA.gripe][dmca]
- [Rokket.space][rokket]
- [Pastebin][pastebin]

### Installation

`npm install --global pastify`

### Usage

`pastify <service> [file|stream]`

### Examples

`pastify pb ~/.vimrc`

`pastify pb <(ps aux)`

`dmesg | pastify iop`

`PB_API_DEV=XXXX PRIVACY=0 pastify pb /tmp/leak.txt`

### Todos

- Add ghostbin
- Add github gist
- Add gitlab snippets


### Contributing

Fork it:
`https://github.com/ryanmaynard/pastify/fork`

Create your feature branch:
`git checkout -b my-new-feature`

Commit your changes:
`git commit -am 'Add some feature'`

Push to the branch:
`git push origin my-new-feature`

Create a new Pull Request:
`https://github.com/ryanmaynard/pastify/compare`

### License

* [MIT TLDR][mit]
* [License Text][license]


[uguu]: https://uguu.se
[mixtape]: https://mixtape.moe
[catbox]: https://catbox.moe
[dmca]: https://dmca.gripe
[rokket]: https://rokket.space
[pastebin]: https://pastebin.com
[mit]: https://tldrlegal.com/license/mit-license
[license]: https://github.com/ryanmaynard/pastify/blob/master/LICENSE
