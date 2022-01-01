{#
# vim: se filetype=i3 :
#}

# Run the lxpolkit daemon
exec --no-startup-id mate-polkit & disown

{% if ansible_hostname != "sam_laptop" %}
# I want pretty GUI transitions and stuff!
exec --no-startup-id compton -f & disown
{% endif %}

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
exec --no-startup-id xautolock -time 5 -locker ~/code/personal/dotfiles/dotfiles/i3/scripts/lock.sh

# Set the desktop background
{% if ansible_hostname != "sam_laptop" %}
exec --no-startup-id feh --bg-scale ~/Pictures/desktop.jpg
{% else %}
exec --no-startup-id feh --bg-scale ~/.background-image
{% endif %}

# TODO - Run a script to detect if I'm docked or not and choose layout accordingly.
{% if ansible_hostname != "sam_laptop" %}
# Set Keyboard layout to US
exec --no-startup-id setxkbmap -layout us -option ctrl:nocaps
{% else %}
# Set Keyboard layout to GB by nixOS, no action needed here.
{% endif %}

# Auto-mount disks
exec --no-startup-id udiskie --tray & disown

# Ensure that my primary network connection is brought up
{% if ansible_hostname == "sm-fswbsk013" %}
exec --no-startup-id nmcli connection up Ethernet
{% elif ansible_hostname == "sam-elem-desktop" %}
exec --no-startup-id nmcli connection up no2hp
{% endif %}

# Setup polybar
{% if ansible_hostname == "sam_laptop" %}
exec -no-startup-id systemctl --user restart polybar
{% endif %}
