#!/bin/sh
#############################################
#              General Settings             #
#############################################
xset r rate 200 95
picom --experimental-backends -b
nitrogen --restore
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
greenclip daemon &
unclutter &
