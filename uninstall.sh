#!/bin/bash

if [[ -n "$@" ]]; then
    files="$@"

    # Redefine myvar to files using parenthesis
    file_arr=($files)

    # echo "My array: ${file_arr[@]}"
    # echo "Number of elements in the array: ${#file_arr[@]}"
    for file in "${file_arr[@]}"
    do 
        [[ $file = .* ]] && file="$HOME/$file" || file="$HOME/.config/$file"
        if [[ -L "$file" ]]; then
            unlink "$file" && echo "Unlinked $file"
        fi
    done
else
    for file in $HOME/.*
    do
       ## echo "$file"
        [[ -L "$file" ]] && unlink "$file" && echo "Unlinked $file"
    done

    for dir in $HOME/.config/*
    do
       ## echo "$dir"
        [[ -L "$dir" ]] && unlink "$dir" && echo "Unlinked $dir"
    done
fi
