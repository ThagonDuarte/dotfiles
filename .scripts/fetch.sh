#!/bin/bash

#Cleanup first
clear

# find the center of the screen
COL=$(tput cols)
ROW=$(tput lines)
# ((PADY = ROW / 2 - 10 - 22 / 2))
# ((PADX = COL / 2 - 34 / 2))
PADY=2
PADX=2

for ((i = 0; i < PADX; ++i)); do
        PADC="$PADC "
done

for ((i = 0; i < PADY; ++i)); do
        PADR="$PADR\n"
done

# vertical padding
printf "%b" "$PADR"
printf "\n"

PADXX=$((PADX - 3))
for ((i = 0; i < PADXX; ++i)); do
        PADCC="$PADCC "
done

nitch &

# hide the cursor and wait for user input
tput civis
read -n 1

# give the cursor back
tput cnorm

