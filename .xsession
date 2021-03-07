#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

DEFAULT_SESSION='dwm'

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# start some nice programs

get_session(){
	case $1 in
		dwm) echo "dwm" ;;
		i3) echo "i3" ;;
		awesome) echo "awesome" ;;
		bspwm) echo "bspwm-session" ;;
		xfce) echo xfce4-session ;;
		openbox) echo openbox-session ;;
		*) echo "$DEFAULT_SESSION" ;;
	esac
}

session="$(get_session "$1")"
if [ "$session" == 'dwm' ]; then
    $HOME/.config/.system/dwm-bar.sh  
    # Autostart settings
    $HOME/.config/.system/settings.sh
fi

exec "$session"
