# neovim config

As for now this also works for vim(1) but that's gonna change at some point:
At the moment I'm using this on some Debian 11 (and even 9) systems which have so hilariously outdated repos that the available nvim(1) doesn't yet support Lua.
When that changes I'll rewrite the Vim Script parts in Lua.

## Setup

To symlink to `~/.config/nvim` run:
```shell
make
```
Then install and setup [Plug](https://github.com/junegunn/vim-plug)

If you want to use it on vim(1):
1. Clone the repo into `~/.vim`
2. Symlink to vimrc: `ln -s ~/.vim/init.vim ~/.vimrc`
3. Install and setup [Plug](https://github.com/junegunn/vim-plug)

## Removal

```shell
make uninstall
```

For vim(1): Undo the setup steps above, duh ;)

## License
[ISC](https://opensource.org/licenses/ISC)
