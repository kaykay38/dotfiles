#1/bin/sh
#############################################
#               DWM Statusbar               #
#############################################
killall "/bin/sh $HOME/.config/.system/dwm-bar.sh"
while true; do 
    onedrivestatus="$(/home/mia/.config/.system/onedrivestatus)"
    network="$(/usr/local/bin/sb-network-simple)"
    xsetroot -name "$onedrivestatus$network$(date +"  %a ◆  %b %d  ◆ %l:%M %p ")"
    sleep 1
done &
#############################################
