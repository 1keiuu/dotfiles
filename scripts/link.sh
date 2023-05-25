#!/bin/bash

target_files=(
    ".Brewfile" 
    ".gitconfig"
    ".zshrc"
    )

for dotfile in target_files ; do
    ln -fnsv "$dotfile" "$HOME"
done