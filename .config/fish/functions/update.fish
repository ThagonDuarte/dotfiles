function update --wraps='sudo pacman -Syu; yay -Syu --devel' --description 'alias update=sudo pacman -Syu; yay -Syu --devel'
  sudo pacman -Syu; yay -Syu --devel $argv; 
end
