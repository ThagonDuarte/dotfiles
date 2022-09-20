#!/bin/bash
# Install pacman packages
sudo pacman -S $(cat ~/pacman-list)

# Install paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si
cd ~

# Install paru packages
paru -S $(cat ~/paru-list)

# Link all scripts to .local/bin
chmod +x ~/.scripts/* &
~/.scripts/link.sh &

# Link Nextcloud Pictures to home
rm ~/Pictures &
ln -s ~/Nextcloud/Media/Pictures ~ &

# Set evironemnt variables
sudo cp ~/.systemfiles/environment /etc/environment
