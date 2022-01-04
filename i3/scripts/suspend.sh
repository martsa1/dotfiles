#!/bin/bash
set -e
set -x

/home/sam/bin/vpn-global-protect-down || true
lock_script="/home/${USER}/code/personal/dotfiles/i3/scripts/lock.sh"

$lock_script

sleep 3
systemctl suspend

