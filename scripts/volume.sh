#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumeControl.sh up
# $ ./volumeControl.sh down
# $ ./volumeControl.sh mute

# Script modified from these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_volume {
  pactl list sinks | tr ' ' '\n' | grep -m1 '%' | tr -d '%'
}

function is_mute {
  value=$(pactl list sinks | grep Mute | xargs)
  value=${value#*:}
  VAR1="no"

  if [ "$value" = "$VAR1" ]; then
      true
  else
      false
  fi
}

function send_notification {
  iconSound="~/.config/dunst/volume.svg"
  iconMuted="/usr/share/icons/McMuse-circle-dark/status/16/audio-volume-muted.svg"
  echo $(is_mute)
  if is_mute ; then
    dunstify -i $iconMuted -r 2593 -u normal "mute"
  else
    volume=$(get_volume)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    # Send the notification
    dunstify   "Audio Level"    "<b>${volume}%</b>"  -h int:value:"$volume" -i $iconSound -h string:x-dunst-stack-tag:volume
 
  fi
}

case $1 in
  up)
    # set the volume on (if it was muted)
    pactl set-sink-mute @DEFAULT_SINK@ false
    # up the volume (+ 2%)
    current=$(pactl list sinks | tr ' ' '\n' | grep -m1 '%' | tr -d '%')
    [ $current -lt 99 ] && pactl set-sink-volume @DEFAULT_SINK@ +$2%
    send_notification
    ;;
  down)
    pactl set-sink-volume @DEFAULT_SINK@ -$2%
    send_notification
    ;;
  mute)
    # toggle mute
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    send_notification
    ;;
esac
