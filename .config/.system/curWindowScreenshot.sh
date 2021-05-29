#!/bin/sh
#2021-04-07_23h30m25.png
file=$(date +"/home/mia/Pictures/Screenshots/%Y-%m-%d_%Hh%Mm%S.png")

maim -i $(xdotool getactivewindow) "$file" && echo "$file" | xclip -i && notify-send -i "$file" -a 'Scrot' 'Current window screenshot' "Saved to Pictures/Screenshots\nFile path copied to primary"
