#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -9 polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar -c $HOME/.config/polybar/config-i3.ini i3-main 2>/dev/null&
