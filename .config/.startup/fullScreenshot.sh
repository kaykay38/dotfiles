#/bin/sh
file=$(date +"/home/mia/Pictures/Screenshots/%Y-%m-%d_%Hh%Mm%S.png")
scrot $file && notify-send 'Full screenshot saved to Pictures/Screenshots'
processes=$(pgrep -f 'nomacs -m default /home/mia/Pictures/Screenshots')
if [[ ! -z $processes ]]; then
    kill $processes
fi
nomacs -m default $file
