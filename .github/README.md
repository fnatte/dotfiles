# dotfiles

```sh
git clone --bare git@github.com:fnatte/dotfiles.git $HOME/.dotfiles-git
git --git-dir=$HOME/.dotfiles-git/ --work-tree=$HOME checkout
```

```sh
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-git --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles status
```
