#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/picom"

if pgrep -x picom; then
  # Terminate already running bar instances
  killall -q picom 
else
  # Launch picom
  picom --experimental-backends&
fi

