#!/bin/bash

scripts=("apps" "bar-pc" "bar-laptop" "brightness" "fetch" "launcher" "powermenu" "quicklinks" "screenshot" "term" "wifimenu" "wrappedhl" "togglepicom")

for script in "${scripts[@]}"; do
  sudo rm /usr/bin/$script 
  sudo chmod +x ~/.scripts/$script.sh 
  sudo ln -s ~/.scripts/$script.sh /usr/bin/$script
done
