#!/bin/bash

# Setup oh-my-fish (omf)
test ! -f ~/.config/fish/conf.d/omf.fish && curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# Set default shell
if ! grep -q fish /etc/shells; then
	echo `which fish` | sudo tee -a /etc/shells
fi
chsh -s `which fish`
