xsetroot -cursor_name left_ptr
setxkbmap -layout de

PANEL_FIFO=/tmp/panel-fifo
PANEL_HEIGHT=24
PANEL_FONT_FAMILY="-*-terminus-medium-r-normal-*-12-*-*-*-c-*-*-1"
export PANEL_FIFO PANEL_HEIGHT PANEL_FONT_FAMILY
export _JAVA_AWT_WM_NONREPARENTING=1

sxhkd &
panel &
gnome-terminal &
compton -cCGfF -o 0.38 -O 200 -I 200 -t 0 -l 0 -r 3 -D2 -m 0.88 &
exec bspwm
