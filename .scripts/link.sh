#!/bin/bash

scripts=("apps" "bar" "brightness" "fetch" "launcher" "powermenu" "quicklinks" "screenshot" "term" "wifimenu" "togglepicom")

for script in "${scripts[@]}"; do
  sudo rm /usr/bin/$script 
  sudo chmod +x ~/.scripts/$script.sh 
  sudo ln -s ~/.scripts/$script.sh /usr/bin/$script
done
