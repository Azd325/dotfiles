#!/bin/bash
export BROWSER=google-chrome
export EDITOR=subl

xsetroot -cursor_name left_ptr
setxkbmap -layout de
xcompmgr &
nitrogen --restore &
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &
volumeicon -b &
batti &
exec xmonad
