#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP-1 --mode 1600x900 --pos 0x0 --rotate normal --output DP1 --off --output DVI-I-1-1 --primary --mode 1920x1080 --pos 1600x0 --rotate normal --output HDMI2 --off --output HDMI1 --off --output DVI-I-2-2 --mode 1920x1080 --pos 3520x0 --rotate normal
#feh --bg-scale ~/Pictures/Backgrounds/arch-nebula-bigger.png
feh --bg-scale ~/Pictures/Backgrounds/triangles-gradient.png

# Terminate polybar
killall -q polybar
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
# Launch polybar again
~/.config/polybar/scripts/launch3.sh
