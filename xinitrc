#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# Hide the cursor when not used
unclutter -grab -noevents -root &

# Use a basic cursor
xsetroot -cursor_name left_ptr &

nitrogen --restore

SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add &

exec qtile
