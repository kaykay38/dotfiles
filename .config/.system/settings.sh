#!/bin/sh
#############################################
#              General Settings             #
#############################################
dual-vertical-left-monitor
wallpaper.sh
xset r rate 200 95
picom -b
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
greenclip daemon &
unclutter &
