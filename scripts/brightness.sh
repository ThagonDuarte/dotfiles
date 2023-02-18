#!/usr/bin/bash

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_brightness {
  light | cut -d '.' -f 1
}

function send_notification {
  icon="~/.config/dunst/sun.svg"
  brightness=$(get_brightness)
  bar=$(seq -s "⸻" 0 $((brightness / 12)) | sed 's/[0-9]//g')
  # Send the notification

  dunstify   "Backlight Level"    "<b>$(light | cut -d '.' -f 1)%</b>"  -h int:value:"$brightness" -i $icon -h string:x-dunst-stack-tag:brt

}

case $1 in
  up)
    # increase the backlight by 1%
    light -A $2
    send_notification
    ;;
  down)
    # decrease the backlight by 1%
    light -U $2 
    send_notification
    ;;
esac
