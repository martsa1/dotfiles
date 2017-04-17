#!/bin/bash

track=$(playerctl metadata title)
artist=$(playerctl metadata artist)

echo -e "$artist - $track"
