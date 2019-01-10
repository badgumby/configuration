#!/bin/bash

# Terminate polybar
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch 1 per monitor
MONITOR=eDP-1 polybar eDP1 &
MONITOR=DVI-I-1-1 polybar DVI1 &
MONITOR=DVI-I-2-2 polybar DVI2 &
