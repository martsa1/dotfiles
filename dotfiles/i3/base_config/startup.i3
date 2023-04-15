{#
# vim: se filetype=i3 :
#}

{% if ansible_hostname not in ("sam_laptop", "sm-fswbsk088") %}
# Run the lxpolkit daemon
exec --no-startup-id mate-polkit & disown
{% endif %}

{% if ansible_hostname not in ("sam_laptop", "fswbsk088") %}
# I want pretty GUI transitions and stuff!
exec --no-startup-id compton -f & disown
{% endif %}

# # I also want to get a browser, terminal and music to start on login
exec firefox-dev & disown
exec spotify & disown
exec alacritty & disown

{% if ansible_hostname not in ("sam_laptop", "sm-fswbsk088") %}
exec --no-startup-id flameshot --min_at_startup & disown
{% endif %}

# Enable numlock by default
exec --no-startup-id numlockx on

{% if ansible_hostname not in ("sam_laptop", "sm-fswbsk088") %}
# Network Manager Applet & gnome settings daemon
exec --no-startup-id nm-applet
exec --no-startup-id gnome-settings-daemon
{% endif %}

{% if ansible_hostname not in ("sam_laptop", "sm-fswbsk088") %}
# Lock on timeout
exec --no-startup-id xautolock -time 5 -locker ~/code/personal/dotfiles/i3/scripts/lock.sh
{% else %}
# Lock on timeout
exec --no-startup-id xautolock -time 5 -locker ~/.config/nixpkgs/dotfiles/i3/scripts/lock.sh
{% endif %}

{% if ansible_hostname not in ("sam_laptop", "sm-fswbsk088") %}
# Set the desktop background
exec --no-startup-id feh --bg-scale ~/Pictures/desktop.jpg
#{% else %}
#exec --no-startup-id feh --bg-scale ~/.background-image
{% endif %}

{% if ansible_hostname not in ("sam_laptop", "sm-fswbsk088") %}
# TODO - Run a script to detect if I'm docked or not and choose layout accordingly.
# Set Keyboard layout to US
exec --no-startup-id setxkbmap -layout us -option ctrl:nocaps
{% else %}
# Set Keyboard layout to GB by nixOS, no action needed here.
{% endif %}

{% if ansible_hostname not in ("sam_laptop", "sm-fswbsk088", "sm-fswbsk013") %}
# Auto-mount disks
exec --no-startup-id udiskie --tray & disown
{% endif %}

{% if ansible_hostname == "sm-fswbsk013" %}
# Ensure that my primary network connection is brought up
exec --no-startup-id nmcli connection up Ethernet
{% elif ansible_hostname == "sam-elem-desktop" %}
# Ensure that my primary network connection is brought up
exec --no-startup-id nmcli connection up no2hp
{% endif %}

{% if ansible_hostname == "sam_laptop" %}
# Setup polybar
exec -no-startup-id systemctl --user restart polybar
{% endif %}
