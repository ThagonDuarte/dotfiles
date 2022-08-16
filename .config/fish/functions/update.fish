function update --wraps='sudo pacman -Syu; prau -Syu --devel' --description 'alias update=sudo pacman -Syu; prau -Syu --devel'
  sudo pacman -Syu; paru -Syu --devel $argv; 
end
