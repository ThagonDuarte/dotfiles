#!/usr/bin/env bash

DIR="$HOME/.config/polybar/pc"
SDIR="$HOME/.config/polybar/"
# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/styles.rasi \
<<< " Round| Cuts|")"
   case "$MENU" in
      *Round) "$DIR"/setstyle.sh --mode1 ;;
      *Cuts) "$DIR"/setstyle.sh --mode2 ;;
   esac