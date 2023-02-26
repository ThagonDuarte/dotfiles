NUM_DISPLAYS=`xrandr --query | grep " connected" | cut -d" " -f1 | wc -l`
ACTION=$1

if [[ $NUM_DISPLAYS > 1 ]];then
  if [[ $ACTION="--enable" ]]; then 
    `hyprctl keyword monitor "eDP-1, 2256x1504, 1920x1440, 1.25"`
  fi
  if [[ $ACTION="--disable" ]]; then
    `hyprctl keyword monitor "eDP-1, disable"`
  fi
fi
