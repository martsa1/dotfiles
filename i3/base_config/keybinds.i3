{#
# vim: se filetype=i3 :
#}

# Use the windows/meta key as i3 modifier
set $mod Mod4

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec alacritty

# kill focused window
bindsym $mod+Shift+q kill

# Use Rofi as default launcher
bindsym $mod+d exec rofi -show run
bindsym $mod+Shift+d exec rofi -show ssh
bindsym $mod+Ctrl+d exec rofi -show emoji -modi emoji

# Launch a file browser
# If Nautilus tries to launch a Desktop, try running:
# gsettings set org.gnome.desktop.background show-desktop-icons false
bindsym $mod+n exec nautilus

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# Toggle split direction (Used to have separate binds)
bindsym $mod+t split toggle
# # split in horizontal orientation
# bindsym $mod+h split h
# # split in vertical orientation
# bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
bindsym $mod+z focus child

# Rename a workspace
bindsym $mod+Shift+backslash exec \
  '/home/{{ user }}/.config/i3/scripts/rename_workspace.py'

# switch to workspace
bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5
bindsym $mod+6 workspace number 6
bindsym $mod+7 workspace number 7
bindsym $mod+8 workspace number 8
bindsym $mod+9 workspace number 9
bindsym $mod+0 workspace number 10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5
bindsym $mod+Shift+6 move container to workspace number 6
bindsym $mod+Shift+7 move container to workspace number 7
bindsym $mod+Shift+8 move container to workspace number 8
bindsym $mod+Shift+9 move container to workspace number 9
bindsym $mod+Shift+0 move container to workspace number 10

# Move workspace to other screen (Uses < and >)
bindsym $mod+Shift+period move workspace to output right
bindsym $mod+Shift+comma move workspace to output left

mode "Move Window" {
        # These bindings trigger as soon as you enter the Move Window mode

        bindsym a move workspace to output left
        bindsym s move workspace to output down
        bindsym w move workspace to output up
        bindsym d move workspace to output right

        bindsym h move workspace to output left
        bindsym j move workspace to output down
        bindsym k move workspace to output up
        bindsym l move workspace to output right

        bindsym Left move workspace to output left
        bindsym Down move workspace to output down
        bindsym Up move workspace to output up
        bindsym Right move workspace to output right

        bindsym Return mode "default"
        bindsym Escape mode "default"
}
bindsym $mod+m mode "Move Window"

# Cycling through all workspaces
bindsym $mod+Next workspace next
bindsym $mod+Prior workspace prev

# Cycling through all workspaces on the current monitor
bindsym $mod+Shift+Next workspace next_on_output
bindsym $mod+Shift+Prior workspace prev_on_output

# reload the configuration file
bindsym $mod+Shift+c reload

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m \
  'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# Lock the session
bindsym $mod+Shift+x exec /home/sam/.config/i3/scripts/lock.sh

# Screenshot utility
bindsym --release Print exec --no-startup-id \
  "flameshot launcher -p ~/Pictures/screenshots"

# Capture the current screen
bindsym --release $mod+Print exec --no-startup-id \
  "flameshot screen -p ~/Pictures/screenshots"

# Selectable area to capture
bindsym --release $mod+Shift+Print exec --no-startup-id \
  "flameshot gui -p ~/Pictures/screenshots"

# resize window (you can also use the mouse for that)
mode "Resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym h resize shrink width 10 px or 10 ppt
        bindsym j resize grow height 10 px or 10 ppt
        bindsym k resize shrink height 10 px or 10 ppt
        bindsym l resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}
bindsym $mod+r mode "Resize"

# Brightness controls
bindsym XF86MonBrightnessUp exec --no-startup-id sudo brightnessctl s 5%+
bindsym XF86MonBrightnessDown exec --no-startup-id sudo brightnessctl s 5%-

# Volume controls
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl \
  set-sink-volume @DEFAULT_SINK@ +5% #increase sound volume

bindsym XF86AudioLowerVolume exec --no-startup-id pactl \
  set-sink-volume @DEFAULT_SINK@ -5% #decrease sound volume

bindsym XF86AudioMute exec --no-startup-id pactl \
  set-sink-mute @DEFAULT_SINK@ toggle # mute sound

bindsym XF86AudioPlay exec playerctl play-pause
bindsym XF86AudioPause exec playerctl play-pause

bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous

# incase we have media keys but not play/pause
bindsym XF86Mail exec playerctl next
bindsym XF86HomePage exec playerctl previous

# Go to sleep!
bindsym XF86Sleep --release exec "systemctl suspend"

# Use the keyboard calculator button to launch a calculator
bindsym XF86Calculator exec "gnome-calculator"

# Keepmenu (Keepass for Rofi)
bindsym $mod+p exec keepmenu

# Rofipass (Pass with Rofi)
bindsym $mod+shift+p exec rofi-pass

# Rofi Window switcher
bindsym $mod+shift+w exec rofi -show window

# Rofi Calculator
bindsym $mod+c exec rofi -show calc -modi calc -no-show-match -no-sort

#####################################################
# Move to scratchpad
bindsym $mod+shift+minus move scratchpad

# Toggle show scratchpad
bindsym $mod+minus scratchpad show
