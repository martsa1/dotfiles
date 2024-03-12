#!/usr/bin/env bash

set -exu


if [ -e /etc/NIXOS ]; then
    locktool=i3lock
else
    locktool=/usr/bin/i3lock
fi

scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
if [[ -n "${1-}" ]] && [[ -f $1 ]]; then
    convert /tmp/screen.png "$1" -gravity center -composite -matte /tmp/screen.png
fi

echo "locking"
playerctl pause || true
$locktool -f -e -b -i /tmp/screen.png
rm -rf /tmp/screen.png
