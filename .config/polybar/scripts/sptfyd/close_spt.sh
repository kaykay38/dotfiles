#!/usr/bin/sh

if [ ! -z $(pidof spotifyd) ]; then
    killall -9 spotifyd &
    notify-send "Spotify" "Closing..." --icon="$HOME/.config/spotifyd/spotifyicon.png"
fi
