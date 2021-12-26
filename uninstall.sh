#!/bin/bash

for file in $HOME/.*
do
   ## echo "$file"
    [[ -L "$file" ]] && unlink "$file" && echo "Unlinked $file"
done

for dir in $HOME/.config/
do
   ## echo "$dir"
    [[ -L "$dir" ]] && unlink "$dir" && echo "Unlinked $dir"
done
