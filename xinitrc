#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

/usr/bin/VBoxClient-all

# Hide the cursor when not used
unclutter -grab -noevents -root &

# Use a basic cursor
xsetroot -cursor_name left_ptr &

# Load Xresources
xrdb -merge ~/.Xresources

# Terminal daemon
urxvtd &

setxkbmap -layout de

nitrogen --restore

udiskie -2 &

# Screen locking
xautolock -locker lockthescreen -time 10 &

SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add &

exec qtile
