#1/bin/sh
#############################################
#               DWM Statusbar               #
#############################################
killall "/bin/sh $HOME/.config/.system/dwm-bar.sh"
while true; do 
    vpnStatus="$(ip a | grep 'tun0' | grep 'inet')"
    vpnIcon=""
    if [[ ! -z "$vpnStatus" ]]; then
        vpnIcon="    Connected  |"
    fi
    xsetroot -name "$vpnIcon$(date +"  %a ◆  %b %d  ◆ %l:%M %p ")"
    sleep 1
done &

vpn () {
    vpnStatus="$(ip a | grep 'tun0' | grep 'inet')"
    if [[ ! -z "$vpnStatus" ]]; then
        printf "    Connected  |"
    fi
}

datetime () {
    printf "$(date +"  %a ◆  %b %d  ◆ %l:%M %p ")"
}

#############################################
