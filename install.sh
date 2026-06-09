#!/bin/bash

repo="$(pwd)"

link_config() {
    local source="$1"
    local target="$2"

    if [[ -e "$target" || -L "$target" ]]; then
        echo "Skipped $target; already exists"
        return
    fi

    ln -s "$source" "$target" && echo "Linked $source -> $target"
}

should_skip() {
    local name="$1"

    [[ $name == "." || $name == ".." || $name == ".git" || $name == ".gitignore" || $name == *.bak ]]
}

link_name() {
    local name="$1"

    if should_skip "$name"; then
        echo "Skipped $name"
        return
    fi

    if [[ $name = .* ]]; then
        link_config "$repo/$name" "$HOME/$name"
    else
        link_config "$repo/.config/$name" "$HOME/.config/$name"
    fi
}

if (( $# > 0 )); then
    for name in "$@"; do
        link_name "$name"
    done
else
    for source in "$repo"/.*; do
        name="$(basename "$source")"

        should_skip "$name" && continue

        link_config "$source" "$HOME/$name"
    done

    for source in "$repo"/.config/*; do
        name="$(basename "$source")"

        link_config "$source" "$HOME/.config/$name"
    done
fi
