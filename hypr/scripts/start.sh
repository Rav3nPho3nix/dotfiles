#!/usr/bin/env bash
# waybar
nb_moniteur=$(hyprctl monitors | grep "Monitor" | wc -l)
if [ "$nb_moniteur" -eq 1 ]; then
    waybar -c .config/waybar/config-1 -s .config/waybar/style-1.css
else
    waybar -c .config/waybar/config-2 -s .config/waybar/style-2.css
fi
