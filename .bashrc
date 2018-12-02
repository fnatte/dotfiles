#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT="$HOME/bash-it"

# Point bash-it to custom bash directory (which is under SVC).
export BASH_IT_CUSTOM="$HOME/.config/bash"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='powerline'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@github.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="todo"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

export EDITOR=nvim

export GOPATH=~/Code/go

export USER_HOME=$HOME

export NVM_DIR="$HOME/.nvm"

export GPG_TTY=`tty`

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

[[ -f $HOME/.secrets.sh ]] && source "$HOME/.secrets.sh"

# Load Bash It
source $BASH_IT/bash_it.sh

if [ "$(uname)" == "Darwin" ]; then
	# Prevent ctrl-d from exit shell
	set -o ignoreeof
	echo ""

	export PATH=$PATH:/usr/local/texlive/2016basic/bin/x86_64-darwin
	source "/usr/local/opt/nvm/nvm.sh"
else
	setxkbmap -layout 'us,se' -option 'grp:switch'
	setxkbmap -option caps:escape

	# Make sure we are not in caps
	CAPS_LOCK_STATE=$(xset q | awk '/Caps Lock/ {print $4}')
	[ "$CAPS_LOCK_STATE" == "on" ] && xdotool key Caps_Lock

	export LC_ALL=en_US.UTF-8
	export LANG="$LC_ALL"

	export CHROME_BIN=/usr/bin/chromium
	export BIOMBO_REPO=~/Code/biombo/repo
fi

PATH=$PATH:~/.gem/ruby/2.3.0/bin
PATH=$PATH:~/.config/composer/vendor/bin
PATH=$PATH:$GOPATH/bin
PATH="$PATH:$(yarn global bin)"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'

