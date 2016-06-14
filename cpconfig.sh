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

copy ".xmonad/xmonad.hs" "xmonad/xmonad.hs"
copy ".xmobarrc" "xmonad/xmobarrc"

copy ".config/i3/config" "i3/config"
copy ".config/i3status/config" "i3/i3status"

copy ".vimrc" "dotfiles/vimrc"
copy ".vimperatorrc" "dotfiles/vimperatorrc"

copy ".bashrc" "dotfiles/bashrc"
copy ".zshrc" "dotfiles/zshrc"
copy ".zprofile" "dotfiles/zprofile"

copy ".gtkrc-2.0" "dotfiles/gtkrc-2.0.mine"
copy ".Xresources" "dotfiles/Xresources"
copy ".xinitrc" "dotfiles/xinitrc"

echo -e "\nDone!"
