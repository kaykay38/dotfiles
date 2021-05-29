#/bin/sh
file=$(date +"/home/mia/Pictures/Screenshots/%Y-%m-%d_%Hh%Mm%S.png")

sleep .5
maim -s "$file" && echo "$file" | xclip -i && notify-send -i "$file" -a 'Scrot' 'Selection screenshot' "Saved to Pictures/Screenshots\nFile path copied to primary"
