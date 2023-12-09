dotdir = $(shell pwd)

.DEFAULT_GOAL := all

all: install

install:
	@ln -sf ${dotdir}/config ~/.config/nvim
	@echo "config symlinked"
	@echo "Setup Plug: https://github.com/junegunn/vim-plug"

uninstall:
	rm -f ~/.config/nvim
	rm -rf ~/.local/share/nvim

.PHONY: all install uninstall
