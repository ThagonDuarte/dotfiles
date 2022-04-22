# dotfiles
My personal dotfiles
git init --bare ~/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
config remote add origin git@github.com:ThagonDuarte/dotfiles.git
config pull
