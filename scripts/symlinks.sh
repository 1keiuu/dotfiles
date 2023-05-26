#!/bin/bash

SCRIPT_DIR="$(cd "$("../$dirname" "$0")" && pwd)"

target_files=(
    ".Brewfile" ".gitconfig" ".zshrc"
    )

for dotfile in "${target_files[@]}"
 do
    ln -fnsv "${SCRIPT_DIR}/$dotfile" $HOME
done
