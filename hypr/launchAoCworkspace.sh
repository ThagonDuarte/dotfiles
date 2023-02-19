#!/usr/bin/env bash
hyprctl dispatch -- workspace empty
hyprctl dispatch -- exec firefox --new-window https://doc.rust-lang.org/stable/book/ch02-00-guessing-game-tutorial.html
sleep 1
hyprctl dispatch -- exec firefox --new-tab https://doc.rust-lang.org/std/index.html
hyprctl dispatch -- exec firefox --new-tab https://adventofcode.com/2022
sleep 7 
hyprctl dispatch -- exec kitty nvim ~/Projects/AoC2022
