#/bin/sh
file=$(date +"/home/mia/Pictures/Screenshots/%Y-%m-%d_%Hh%Mm%S.png")

function openNomacs() {
    processes=$(pgrep -f 'nomacs -m default /home/mia/Pictures/Screenshots')
    if [[ ! -z $processes ]]; then
        kill $processes
    fi
    nomacs -m default $file
}

maim "$file" && echo "$file" | xclip -i && notify-send -i "$file" -a 'Scrot' 'Screenshot' "Saved to Pictures/Screenshots\nFile path copied to primary"
