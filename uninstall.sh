#!/bin/bash

repo="$(pwd)"

unlink_config() {
    local source="$1"
    local target="$2"

    [[ -L "$target" ]] || return

    if [[ $(readlink "$target") != "$source" ]]; then
        echo "Skipped $target; points somewhere else"
        return
    fi

    unlink "$target" && echo "Unlinked $target"
}

should_skip() {
    local name="$1"

    [[ $name == "." || $name == ".." || $name == ".git" || $name == ".gitignore" || $name == *.bak ]]
}

unlink_name() {
    local name="$1"

    if should_skip "$name"; then
        echo "Skipped $name"
        return
    fi

    if [[ $name = .* ]]; then
        unlink_config "$repo/$name" "$HOME/$name"
    else
        unlink_config "$repo/.config/$name" "$HOME/.config/$name"
    fi
}

if (( $# > 0 )); then
    for name in "$@"; do
        unlink_name "$name"
    done
else
    for source in "$repo"/.*; do
        name="$(basename "$source")"

        should_skip "$name" && continue

        unlink_config "$source" "$HOME/$name"
    done

    for source in "$repo"/.config/*; do
        name="$(basename "$source")"

        unlink_config "$source" "$HOME/.config/$name"
    done
fi
