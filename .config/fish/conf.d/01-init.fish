if test -e ~/.secrets.sh
  source ~/.secrets.sh
end

set fish_prompt_pwd_dir_length 2

set -xg EDITOR 'nvim'
set -xg BROWSER 'firefox'

# Set nvim dir (containing nvm.sh). This is used by nvm omf-plugin.
set -xg NVM_DIR '/usr/share/nvm'

# Append PATH
set -gx PATH $PATH $HOME/bin
type -q yarn && set -gx PATH $PATH (yarn bin)
type -q go && set -gx PATH $PATH (go env GOPATH)/bin
type -q composer && set -gx PATH $PATH (composer global config bin-dir --absolute --quiet)
type -qf /opt/homebrew/bin/brew && eval (/opt/homebrew/bin/brew shellenv)

# GCloud
set GCLOUD_PATH (type -q gcloud && gcloud info --format="value(installation.sdk_root)")
if test -n "$GCLOUD_PATH"
  source "$GCLOUD_PATH/path.fish.inc"
end

# Flutter
set -gx FLUTTER_HOME /opt/flutter
set -gx PATH $PATH $FLUTTER_HOME/bin
set -gx PATH $PATH /opt/flutter/.pub-cache/bin

# Use the ssh agent socket started by systemd (.config/systemd/user/ssh-agent.service)
set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

bind \cd delete-char

alias vim='nvim'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'

