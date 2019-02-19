if test -e ~/.secrets.sh
  source ~/.secrets.sh
end

set fish_prompt_pwd_dir_length 2

set -xg EDITOR 'nvim'

# Set nvim direction (that contains nvm.sh)
# This is used by nvm omf-plugin
set -xg NVM_DIR '/usr/share/nvm'

# Set neovim-remote address
# - (https://github.com/mhinz/neovim-remote)
# set -xg NVIM_LISTEN_ADDRESS '/tmp/nvimsocket'

# Setup yarn paths
set -gx PATH $PATH (yarn bin)

alias vim='nvim'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME'

