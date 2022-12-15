#!/usr/bin/bash
swww_fork=~/.config/hypr/tools/swww

if [[ `pgrep -x swww` ]]; then
  echo "Swww is already running."
else
  `$swww_fork init`
  sleep 1
fi
# $swww_fork img $1 --transition-step 90 --transition-type any --transition-duration 5 --transition-fps 255 --transition-bezier=0.85,0,0.15,1
swww img $1 --transition-step 255 --transition-type any --transition-pos 0.5,0.5 --transition-duration 2 

