if test -e ~/.secrets.sh
  source ~/.secrets.sh
end

set fish_prompt_pwd_dir_length 2

set -xg EDITOR 'nvim'
set -xg BROWSER 'firefox'

# Set nvim direction (that contains nvm.sh)
# This is used by nvm omf-plugin
set -xg NVM_DIR '/usr/share/nvm'

# Set neovim-remote address
# - (https://github.com/mhinz/neovim-remote)
# set -xg NVIM_LISTEN_ADDRESS '/tmp/nvimsocket'

# Append PATH
set -gx PATH $PATH $HOME/bin
type -q yarn && set -gx PATH $PATH (yarn bin)
type -q go && set -gx PATH $PATH (go env GOPATH)/bin
type -q composer && set -gx PATH $PATH (composer global config bin-dir --absolute --quiet)

# Flutter
set -gx FLUTTER_HOME /opt/flutter
set -gx PATH $PATH $FLUTTER_HOME/bin
set -gx PATH $PATH /opt/flutter/.pub-cache/bin

bind \cd delete-char

alias vim='nvim'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'

