#!/bin/bash

if [[ -n "$@" ]]; then
    files="$@"

    # Redefine myvar to files using parenthesis
    file_arr=($files)

    # echo "My array: ${file_arr[@]}"
    # echo "Number of elements in the array: ${#file_arr[@]}"
    for file in "${file_arr[@]}"
    do 
        if [[ $file = .* ]]; then 
            ln -s "$(pwd)/$file" "$HOME/$file" && echo "Linked $(pwd)/$file -> $HOME/$file"
        else
            ln -s "$(pwd)/.config/$file" "$HOME/.config/" && echo "Linked $(pwd)/.config/$file -> $HOME/.config/$file"
        fi
    done
else
    for file in $(pwd)/.*
    do 
        ln -s "$file" "$HOME/" && echo "Linked $file -> $HOME/$file"
    done
    for file in $(pwd)/.config/*
    do 
        ln -s "$file" "$HOME/.config/" && echo "Linked $file -> $HOME/.config/$file"
    done
fi
