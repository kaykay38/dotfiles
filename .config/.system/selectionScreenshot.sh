#/bin/sh
file=$(date +"/home/mia/Pictures/Screenshots/%Y-%m-%d_%Hh%Mm%S.png")

function openNomacs() {
    processes=$(pgrep -f 'nomacs -m default /home/mia/Pictures/Screenshots')
    if [[ ! -z $processes ]]; then
        kill $processes
    fi
    nomacs -m default $file
}

sleep .5
scrot -s "$file" && echo "$file" | xclip -i && notify-send -i "$file" -a 'Scrot' 'Selection screenshot' "Saved to Pictures/Screenshots\nFile path copied to primary"
