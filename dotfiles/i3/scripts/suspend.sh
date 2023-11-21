#!/bin/bash
set -ex

lock_script="$HOME/.config/home-manager/dotfiles/i3/scripts/lock.sh"

vpn-down
# Halt teams
ps -elf | rg chrome | rg cifhbcnohmdccbgoicgdjpfamggdegmo | tr -s ' ' | cut -d ' ' -f 4 | xargs -r kill

$lock_script

sleep 3
systemctl suspend

