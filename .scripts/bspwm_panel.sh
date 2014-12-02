#! /bin/sh

if [ $(pgrep -cx panel) -gt 1 ] ; then
	printf "%s\n" "The panel is already running." >&2
	exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

bspc config top_padding $PANEL_HEIGHT
bspc control --subscribe > "$PANEL_FIFO" &
xtitle -sf 'T%s' > "$PANEL_FIFO" &
clock -sf 'S%a %H:%M' > "$PANEL_FIFO" &

. panel_config

cat "$PANEL_FIFO" | panel_bar | bar -g x$PANEL_HEIGHT -f "$PANEL_FONT_FAMILY" -F "$COLOR_FOREGROUND" -B "$COLOR_BACKGROUND" &

wait