#!/bin/sh
#############################################
#               DWM Statusbar               #
#############################################
while true; do 
    network="$(/usr/local/bin/sb-network-simple)"
    onedrivestatus="$(/usr/local/bin/sb-onedrive)"
    player="$(/usr/local/bin/sb-playerctl)"
    xsetroot -name "$player$onedrivestatus$network$(date +" %a %b %d  | %l:%M %p ")"
    sleep 1
done &
#############################################
