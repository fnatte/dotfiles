#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT="/Users/matteus.hemstrom/bash-it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='powerline'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

export EDITOR=nvim

export GOPATH=~/Code/go

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# Load Bash It
source $BASH_IT/bash_it.sh

if [ "$(uname)" == "Darwin" ]; then
	# Prevent ctrl-d from exit shell
	set -o ignoreeof
	echo ""
else
	setxkbmap -layout 'us,se' -option 'grp:switch'
	setxkbmap -option caps:escape

	export LC_ALL=en_US.utf-8 
	export LANG="$LC_ALL"
fi

PATH=$PATH:~/.gem/ruby/2.3.0/bin
PATH=$PATH:~/.config/composer/vendor/bin
PATH=$PATH:$GOPATH/bin

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'
