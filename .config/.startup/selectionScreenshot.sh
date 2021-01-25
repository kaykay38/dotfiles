#/bin/sh
file=$(date +"/home/mia/Pictures/Screenshots/%Y-%m-%d_%Hh%Mm%S.png")
sleep .2
scrot -s $file && notify-send 'Full screenshot saved to Pictures/Screenshots' && openNomacs
openNomacs() {
processes=$(pgrep -f 'nomacs -m default /home/mia/Pictures/Screenshots')
    if [[ ! -z $processes ]]; then
        kill $processes
    fi
    nomacs -m default $file
}
