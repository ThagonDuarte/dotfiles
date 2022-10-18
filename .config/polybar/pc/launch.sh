#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/pc"
STYLE="-round"

# Terminate already running bar instances
killall -q polybar
kill xembedsniproxy

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #if [ $m == "HDMI-0"  ]; then
    #  MONITOR=$m polybar --reload -q top -c "$DIR"/config$STYLE.ini &
    #  MONITOR=$m polybar --reload -q bottom -c "$DIR"/config$STYLE.ini &
    #fi  
    if [ $m == "DP-2" ]; then
      MONITOR=$m polybar --reload -q top-center -c "$DIR"/config$STYLE.ini &
    fi  
  done
else
  polybar -q top -c "$DIR"/config$STYLE.ini &
  polybar -q bottom -c "$DIR"/config$STYLE.ini &
fi
