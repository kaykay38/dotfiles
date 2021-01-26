#############################################
#               DWM Statusbar               #
#############################################
while true; do 
    vpnStatus="$(ip a | grep tun0 | grep inet | grep global | wc -l)"
    vpnIcon=""
    if [[ "$vpnStatus" == '1' ]]; then
        vpnIcon="    Connected  |"
    fi
    xsetroot -name "$vpnIcon$(date +"  %a ◆  %b %d  ◆ %l:%M %p ")"
    sleep 1
done &

vpn () {
    status="$(ip a | grep tun0 | grep inet | grep global | wc -l)"
    if [[ "$status" == '1' ]]; then
        echo "   Connected "
    fi
}

datetime () {
    echo "$(date +"  %a   %b %d  ♦ %l:%M %p  ")"
}

#############################################
