#!/usr/bin/sh


# see man zscroll for documentation of the following parameters
if [ ! -z "$(pidof spotify)" ]; then
    zscroll -l 30 \
        --delay 0.1 \
        --match-command "playerctl --player=spotify status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --match-text "Stopped" "--scroll 0" \
        --match-text "No players found" "--scroll 0" \
        --update-check true 'python3 /home/mia/.config/polybar/scripts/sptfy/sptfy_status.py' &
fi
wait
