#!/bin/bash

exec xautolock -detectsleep \
  -time 5 -locker "~/.config/i3/i3lock-fancy-multimonitor/lock -n -p" \
  -notify 30 \
  -notifier "notify-send -u critical -t 10000 -- 'Locking screen in 30 seconds'"
