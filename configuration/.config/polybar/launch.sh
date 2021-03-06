#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit

# Otherwise you can use the nuclear option:
# killall -q polybar

echo "---" | tee -a /tmp/polybar_main.log
polybar main 2>&1 --config=~/.config/polybar/config.ini | tee -a /tmp/polybar_main.log & disown

echo "Bars launched..."
