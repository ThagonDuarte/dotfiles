#!/usr/bin/env bash

SDIR="$HOME/.config/polybar"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/styles.rasi \
<<< " Black| Adapta| Dark| Red| Green| Teal| Gruvbox| Nord| Solarized| Cherry|")"
            case "$MENU" in
				*Black) "$SDIR"/round/scripts/styles.sh --mode1 ;;
				*Adapta) "$SDIR"/round/scripts/styles.sh --mode2 ;;
				*Dark) "$SDIR"/round/scripts/styles.sh --mode3 ;;
				*Red) "$SDIR"/round/scripts/styles.sh --mode4 ;;
				*Green) "$SDIR"/round/scripts/styles.sh --mode5 ;;
				*Teal) "$SDIR"/round/scripts/styles.sh --mode6 ;;
				*Gruvbox) "$SDIR"/round/scripts/styles.sh --mode7 ;;
				*Nord) "$SDIR"/round/scripts/styles.sh --mode8 ;;
				*Solarized) "$SDIR"/round/scripts/styles.sh --mode9 ;;
				*Cherry) "$SDIR"/round/scripts/styles.sh --mode10 ;;
            esac
