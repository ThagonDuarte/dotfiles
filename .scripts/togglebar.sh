#!/bin/bash
if [[ `pidof waybar` ]]; then
  kill `pidof waybar`  
else
  waybar
fi
