#!usr/bin/sh
if [ ! -z $(pidof spotify) ]; then
    if [ $(playerctl --player=spotify status) = "No players found" ]; then
        echo ""
    elif [ $(playerctl --player=spotify status) = "Stopped" ]; then
        echo "No music playing"
    elif [ $(playerctl --player=spotify status) = "Paused" ]; then
        echo "$(playerctl metadata spotify --format "{{ title }} - {{ artist }}")"
    elif [ $(playerctl --player=spotify status) = "Playing" ]; then
        echo "$(playerctl metadata spotify --format "{{ title }} - {{ artist }}")"
    fi
fi
