#!/usr/bin/env bash

# Color files
PFILE="$HOME/.config/polybar/pc/launch.sh"
RFILE="$HOME/.config/polybar/rofi/colors.rasi"

# Change colors
change_style() {
	# polybar
	sed -i -e "s/STYLE=.*/STYLE=${STYLE}/g" $PFILE
	
	# rofi
	cat > $RFILE <<- EOF
	/* colors */

	* {
	  al:   #00000000;
	  bg:   #${BG}BF;
	  bga:  #${BG}FF;
	  fg:   #${FG}FF;
	  ac:   ${AC}FF;
	  se:   ${AC}1A;
	}
	EOF
	
	bar-pc
}

if  [[ $1 = "--mode1" ]]; then
	BG="3C3836"
	FG="EBDBB2"
	AC="#FB4934"
    STYLE="-round"
    change_style
elif  [[ $1 = "--mode2" ]]; then
    BG="3C3836"
	FG="EBDBB2"
	AC="#FB4934"
    STYLE="-cuts"
    change_style
fi