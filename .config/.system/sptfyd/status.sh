#!usr/bin/sh
if [ ! -z $(pidof spotifyd) ]; then
    if [ $(playerctl --player=spotifyd status) = "Stopped" ]; then
        echo "No music playing"
    elif [ $(playerctl --player=spotifyd status) = "Paused" ]; then
        playerctl --player=spotifyd metadata --format "{{ title }} - {{ artist }}"
    elif [ $(playerctl --player=spotifyd status) = "Playing" ]; then
    	playerctl --player=spotifyd metadata --format "{{ title }} - {{ artist }}"
    fi
fi
