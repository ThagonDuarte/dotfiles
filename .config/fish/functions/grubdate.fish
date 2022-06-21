function grubdate --wraps='sudo grub-mkconfig -o /boot/grub/grub.cfg' --description 'alias grubdate sudo grub-mkconfig -o /boot/grub/grub.cfg'
  sudo grub-mkconfig -o /boot/grub/grub.cfg $argv; 
end
