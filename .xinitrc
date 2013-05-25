xsetroot -cursor_name left_ptr
setxkbmap -layout de

# Start a D-Bus session
source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

xcompmgr -c &
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype request --transparent true --alpha 0 --tint 0x000000 --height 16 &
thunar --daemon &
xfce4-power-manager &
nm-applet --sm-disable &
xscreensaver -no-splash &
exec xmonad 
