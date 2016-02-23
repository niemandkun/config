#!/bin/bash

REPO=$(pwd)

function copy {
    if [ -e $HOME/$1 ]; then
        echo "~/$1 --> $2"
        cp "$HOME/$1" "$REPO/$2"
    else
        echo No such ~/$1. Skipping...
    fi
}


echo -e "\nCopying config files to $REPO...\n"

copy ".moc/config" "moc/config"

copy ".config/i3/config" "i3/config"
copy ".config/i3status/config" "i3/i3status"

copy ".xinitrc" "dotfiles/xinitrc"
copy ".Xresources" "dotfiles/Xresources"
copy ".vimrc" "dotfiles/vimrc"
copy ".zshrc" "dotfiles/zshrc"
copy ".vimperatorrc" "dotfiles/vimperatorrc"
copy ".gtkrc-2.0" "dotfiles/gtkrc-2.0.mine"

echo -e "\nDone!"
