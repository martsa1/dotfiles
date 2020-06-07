#!/bin/bash

track=$(playerctl metadata title)
artist=$(playerctl metadata artist)
play_pause=$(playerctl status)

if [ $play_pause = "Playing" ]; then
  echo -e "$artist - $track"
else
  echo -e "$play_pause"
fi
