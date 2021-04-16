#!/bin/sh
#############################################
#               DWM Statusbar               #
#############################################
killall "/bin/sh /home/mia/.config/.system/dwm-bar.sh"
while true; do 
    onedrivestatus="$(/usr/local/bin/sb-onedrive)"
    network="$(/usr/local/bin/sb-network-simple)"
    xsetroot -name "$onedrivestatus$network$(date +" %a %b %d  | %l:%M %p ")"
    sleep 1
done &
#############################################
