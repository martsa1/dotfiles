#!/bin/bash
set +e
set +x

lock_script="$HOME/.config/home-manager/dotfiles/i3/scripts/lock.sh"

$lock_script

sleep 3
systemctl suspend

