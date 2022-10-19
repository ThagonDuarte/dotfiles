#!/usr/bin/env bash
CURRENTSTYLE=`sed -n '/STYLE=/p' ~/.config/polybar/pc/launch.sh | cut -d "=" -f 2` 
echo $CURRENTSTYLE
if [[ $CURRENTSTYLE == '"-round"' ]]; then
    sed 's/round/cuts/g' ~/.config/polybar/pc/launch.sh -i
fi
if [[ $CURRENTSTYLE == '"-cuts"' ]]; then
    sed 's/cuts/round/g' ~/.config/polybar/pc/launch.sh -i
fi

bar-pc