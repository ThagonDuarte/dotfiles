#!/usr/bin/env bash

SDIR="$HOME/.config/polybar/"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/rofi/styles.rasi \
<<< " amber| blue| blue-gray| brown| cyan| deep-orange|\
 deep-purple| green| gray| indigo| blue-light| green-light|\
 lime| orange| pink| purple| red| teal| yellow| amber-dark|\
 blue-dark| blue-gray-dark| brown-dark| cyan-dark| deep-orange-dark|\
 deep-purple-dark| green-dark| gray-dark| indigo-dark| blue-light-dark|\
 green-light-dark| lime-dark| orange-dark| pink-dark| purple-dark| red-dark| teal-dark| yellow-dark|")"
            case "$MENU" in
				## Light Colors
				*amber) "$SDIR"/cuts/scripts/colors-light.sh --amber ;;
				*blue) "$SDIR"/cuts/scripts/colors-light.sh --blue ;;
				*blue-gray) "$SDIR"/cuts/scripts/colors-light.sh --blue-gray ;;
				*brown) "$SDIR"/cuts/scripts/colors-light.sh --brown ;;
				*cyan) "$SDIR"/cuts/scripts/colors-light.sh --cyan ;;
				*deep-orange) "$SDIR"/cuts/scripts/colors-light.sh --deep-orange ;;
				*deep-purple) "$SDIR"/cuts/scripts/colors-light.sh --deep-purple ;;
				*green) "$SDIR"/cuts/scripts/colors-light.sh --green ;;
				*gray) "$SDIR"/cuts/scripts/colors-light.sh --gray ;;
				*indigo) "$SDIR"/cuts/scripts/colors-light.sh --indigo ;;
				*blue-light) "$SDIR"/cuts/scripts/colors-light.sh --light-blue ;;
				*green-light) "$SDIR"/cuts/scripts/colors-light.sh --light-green ;;
				*lime) "$SDIR"/cuts/scripts/colors-light.sh --lime ;;
				*orange) "$SDIR"/cuts/scripts/colors-light.sh --orange ;;
				*pink) "$SDIR"/cuts/scripts/colors-light.sh --pink ;;
				*purple) "$SDIR"/cuts/scripts/colors-light.sh --purple ;;
				*red) "$SDIR"/cuts/scripts/colors-light.sh --red ;;
				*teal) "$SDIR"/cuts/scripts/colors-light.sh --teal ;;
				*yellow) "$SDIR"/cuts/scripts/colors-light.sh --yellow ;;
				## Dark Colors
				*amber-dark) "$SDIR"/cuts/scripts/colors-dark.sh --amber ;;
				*blue-dark) "$SDIR"/cuts/scripts/colors-dark.sh --blue ;;
				*blue-gray-dark) "$SDIR"/cuts/scripts/colors-dark.sh --blue-gray ;;
				*brown-dark) "$SDIR"/cuts/scripts/colors-dark.sh --brown ;;
				*cyan-dark) "$SDIR"/cuts/scripts/colors-dark.sh --cyan ;;
				*deep-orange-dark) "$SDIR"/cuts/scripts/colors-dark.sh --deep-orange ;;
				*deep-purple-dark) "$SDIR"/cuts/scripts/colors-dark.sh --deep-purple ;;
				*green-dark) "$SDIR"/cuts/scripts/colors-dark.sh --green ;;
				*gray-dark) "$SDIR"/cuts/scripts/colors-dark.sh --gray ;;
				*indigo-dark) "$SDIR"/cuts/scripts/colors-dark.sh --indigo ;;
				*blue-light-dark) "$SDIR"/cuts/scripts/colors-dark.sh --light-blue ;;
				*green-light-dark) "$SDIR"/cuts/scripts/colors-dark.sh --light-green ;;
				*lime-dark) "$SDIR"/cuts/scripts/colors-dark.sh --lime ;;
				*orange-dark) "$SDIR"/cuts/scripts/colors-dark.sh --orange ;;
				*pink-dark) "$SDIR"/cuts/scripts/colors-dark.sh --pink ;;
				*purple-dark) "$SDIR"/cuts/scripts/colors-dark.sh --purple ;;
				*red-dark) "$SDIR"/cuts/scripts/colors-dark.sh --red ;;
				*teal-dark) "$SDIR"/cuts/scripts/colors-dark.sh --teal ;;
				*yellow-dark) "$SDIR"/cuts/scripts/colors-dark.sh --yellow				
            esac
