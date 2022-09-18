#!/bin/bash

scripts=("apps" "bar" "brightness" "fetch" "launcher" "powermenu" "quicklinks" "screenshot" "term" "wifimenu")

for script in "${scripts[@]}"; do
  ln -s ~/.scripts/$script.sh ~/.local/bin/$script
done
