#!/bin/bash
set +e
set +x

lock_script="/home/${USER}/code/personal/dotfiles/dotfiles/i3/scripts/lock.sh"

$lock_script

sleep 3
systemctl suspend

