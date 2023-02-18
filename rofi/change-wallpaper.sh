#!/usr/bin/env bash

SDIR="$HOME/.config/rofi"
PICDIR="$HOME/Pictures/Backgrounds/aesthetic/"
ENTRIES=""
for PIC in `ls $PICDIR`; do 
	ENTRIES=$ENTRIES$PIC"|" 
done
echo $ENTRIES

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/wallpaper-changer.rasi \
<<< $ENTRIES)"
						for PIC in `ls $PICDIR`; do 
							if [[ $MENU = $PIC ]]; then
								`~/.config/rofi/applywallpaper.sh $PICDIR$MENU`
							fi	
						done



# -theme $SDIR/launchers/type-1/style-6.rasi \

