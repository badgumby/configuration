#!/bin/sh
xrandr --output HDMI2 --off --output HDMI1 --off --output DP1 --off --output eDP-1 --mode 1600x900 --pos 0x0 --rotate normal --output VIRTUAL1 --off
feh --bg-scale ~/Pictures/Backgrounds/arch-nebula-bigger.png

# Terminate polybar
killall -q polybar
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
# Launch polybar again
~/.config/polybar/scripts/launch.sh
