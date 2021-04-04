#!/usr/bin/sh

if [ -z $(pidof spotifyd) ]; then
    spotifyd &
    notify-send "Spotify" "Ready" "Connect to a device" --icon="$HOME/.config/spotifyd/spotifyicon.png"
elif [ ! -z $(pidof spotifyd) ]; then
    song=$(playerctl --player=spotifyd metadata --format "Title: {{ title }}\nArtist: {{artist}}\nAlbum: {{ album }}")
    notify-send "Currently Playing" "$song" --icon="$HOME/.config/spotifyd/spotifyicon.png"
else 
    notify-send "Spotify" "Cannot open" --icon="$HOME/.config/spotifyd/spotifyicon.png"
fi
