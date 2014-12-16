#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1

# Hide the cursor when not used
unclutter -grab -noevents -root &

# Use a basic cursor
xsetroot -cursor_name left_ptr &

nitrogen --restore

# Enable hotkeys
sxhkd -f 100 &

# Fancy things
compton &

SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add &

exec bspwm 2> ~/.bspwm.log
