#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/styles.rasi \
<<< " Black| Adapta| Dark| Red| Green| Teal| Gruvbox| Nord| Solarized| Cherry|")"
            case "$MENU" in
				*Black) "$SDIR"/cuts/scripts/styles.sh --mode1 ;;
				*Adapta) "$SDIR"/cuts/scripts/styles.sh --mode2 ;;
				*Dark) "$SDIR"/cuts/scripts/styles.sh --mode3 ;;
				*Red) "$SDIR"/cuts/scripts/styles.sh --mode4 ;;
				*Green) "$SDIR"/cuts/scripts/styles.sh --mode5 ;;
				*Teal) "$SDIR"/cuts/scripts/styles.sh --mode6 ;;
				*Gruvbox) "$SDIR"/cuts/scripts/styles.sh --mode7 ;;
				*Nord) "$SDIR"/cuts/scripts/styles.sh --mode8 ;;
				*Solarized) "$SDIR"/cuts/scripts/styles.sh --mode9 ;;
				*Cherry) "$SDIR"/cuts/scripts/styles.sh --mode10 ;;
            esac
