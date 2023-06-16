dotdir = $(shell pwd)

.DEFAULT_GOAL := all

all: install

install:
	ln -sf ${dotdir}/config ~/.config/nvim
	@echo "To install Plug (for plugin management) run:"
	@echo "sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"

uninstall:
	rm -f ~/.config/nvim
	rm -rf ~/.local/share/nvim

.PHONY: all install uninstall
