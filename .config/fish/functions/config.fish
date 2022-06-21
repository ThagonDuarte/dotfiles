function config --wraps='/usr/bin/git --git-dir=/home/alex/.dotfiles/ --work-tree=/home/alex' --description 'alias config /usr/bin/git --git-dir=/home/alex/.dotfiles/ --work-tree=/home/alex'
  /usr/bin/git --git-dir=/home/alex/.dotfiles/ --work-tree=/home/alex $argv; 
end
