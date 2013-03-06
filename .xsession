#!/bin/bash
export BROWSER=google-chrome
export EDITOR=subl

# Start a D-Bus session
source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID


udiskie &
xsetroot -cursor_name left_ptr
setxkbmap -layout de

thunar --daemon &
xcompmgr &
nitrogen --restore &
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 76 --transparent true --alpha 0 --tint 0x000000 --height 16 &
volumeicon -b &
batti &
nm-applet --sm-disable &

exec dbus-launch --sh-syntax --exit-with-session xmonad
