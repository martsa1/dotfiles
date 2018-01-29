#!/usr/bin/env bash

set -x

# Terminate already running bar instances
killall -q polybar;

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done;

# Shamelessly stolen from https://github.com/NAlexPear/i3-workspace-configuration
MONITORS=($(xrandr --query | grep " connected " | cut -d" " -f1))
BARS=("left" "right")

for i in "${!MONITORS[@]}"; do
  MONITOR="${MONITORS[$i]}" polybar --config=$HOME/code/personal/dotfiles/polybar/config --reload "${BARS[$i]}" &
done


echo "Bars launched..."
