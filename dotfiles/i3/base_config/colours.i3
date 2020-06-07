{#
# vim: se filetype=i3 :
#}

# Background/Foreground
set $background     #282A36
set $foreground     #F8F8F2

# Black
set $black          #040404
set $bright_black   #4D4D4D

# Red
set $red            #FF5555
set $bright_red     #DD6E67

# Green
set $green          #50FA7B
set $bright_green   #5AF78E

# Yellow
set $yellow         #F1FA8C
set $bright_yellow  #F4F99D

# Blue
set $purple         #BD93F9
set $bright_purple  #CAA9FA

# Magenta
set $magenta        #FF79C6
set $bright_magenta #FF92D0

# Cyan
set $cyan           #8BE9FD
set $bright_cyan    #9AEDFE

# White
set $white          #BFBFBF
set $bright_white   #E6E6E6

# window colors
#                       border       background   text         indicator  child_border
client.focused          $purple      $purple      $background  $yellow    $purple
client.focused_inactive $green       $green       $background  $yellow    $green
client.unfocused        $background  $background  $white       $yellow    $background
client.urgent           $bright_red  $bright_red  $background  $yellow    $bright_red
#client.focused          $purple     $purple     $background $yellow   $purple
#client.focused_inactive $cyan       $cyan       $background $yellow   $green
#client.unfocused        $green      $green      $background $yellow   $green
#client.urgent           $bright_red $bright_red $background $yellow   $bright_red



