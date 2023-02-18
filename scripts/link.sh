#!/bin/bash

scripts=("apps" "brightness" "fetch" "launcher" "powermenu" "quicklinks" "screenshot" "togglebar" "wifimenu" "wrappedhl" "volume")

for script in "${scripts[@]}"; do
  sudo rm /usr/bin/$script 
  sudo chmod +x ~/.scripts/$script.sh 
  sudo ln -s ~/.scripts/$script.sh /usr/bin/$script
done
