{#
# vim: se filetype=i3 :
#}

# Run the lxpolkit daemon
exec --no-startup-id mate-polkit & disown

# I want pretty GUI transitions and stuff!
exec --no-startup-id compton -f & disown

# # I also want to get a browser, terminal and music to start on login
exec firefox-dev & disown
exec spotify & disown
exec alacritty & disown
exec --no-startup-id flameshot --min_at_startup & disown

# Enable numlock by default
exec --no-startup-id numlockx on

# Network Manager Applet & gnome settings daemon
exec --no-startup-id nm-applet
exec --no-startup-id gnome-settings-daemon

# Lock on timeout
exec --no-startup-id xautolock -time 5 -locker ~/code/personal/dotfiles/i3/scripts/lock.sh

# Set the desktop background
exec --no-startup-id feh --bg-scale ~/Pictures/desktop.jpg

# Set Keyboard layout to US
# TODO - Run a script to detect if I'm docked or not and choose layout accordingly.
exec --no-startup-id setxkbmap -layout us -option ctrl:nocaps

# Auto-mount disks
exec --no-startup-id udiskie --tray & disown


# Ensure that my primary network connection is brought up
{% if ansible_hostname == "sm-fswbsk013" %}
exec --no-startup-id nmcli connection up Ethernet
{% elif ansible_hostname == "sam-elem-desktop" %}
exec --no-startup-id nmcli connection up no2hp
{% endif %}
