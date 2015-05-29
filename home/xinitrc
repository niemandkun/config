#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#GTK_MODULES=$GTK_MODULES, topmenu-gtk-module

#if ! ps ax | grep -v grep | grep statusbar; then
#	sh .statusbar
#fi

xrdb -merge ~/.Xresources
xset r rate 200 40
compton -cCGb # -r 8 -l -11 -t -11 --shadow-exclude "class_g = 'URxvt'"
feh --bg-scale ~/Pictures/ocean.png

exec openbox-session
