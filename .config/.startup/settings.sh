#!/bin/sh
#############################################
#              General Settings             #
#############################################
xset r rate 200 95
picom -b
nitrogen --restore
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
exec volumeicon &
#############################################
#               DWM Statusbar               #
#############################################
while true; do 
    xsetroot -name "$(date +"  %a   %b %d  | %l:%M %p  ")"
    sleep 30
done &
#############################################
