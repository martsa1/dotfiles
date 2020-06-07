#!/bin/bash

config="polybar --config=$HOME/code/personal/dotfiles/polybar/config"

primary="#BD93F9"
secondary="#50FA7B"
alt="#E6E6E6"
elapsed="0"
cache=""

while [[ $(ps -u $USER | grep spotify) ]]; do
  title=`exec playerctl metadata xesam:title 2>/dev/null`
  artist=`exec playerctl metadata xesam:artist 2>/dev/null`
  album=`exec playerctl metadata xesam:album 2>/dev/null`
  length=`exec playerctl metadata mpris:length 2>/dev/null`

  secs=$(($length/1000000))
  timestamp=`printf ""%d:%02d"" $(($secs%3600/60)) $(($secs%60))`


  function update_cache {
    if [ "$cache" != "$artist $title $album $length" ]; then
      cache="$artist $title $album $length"
      elapsed="0"
    fi
  }

  function get_info {
    position=`printf ""%d:%02d"" $(($elapsed%3600/60)) $(($elapsed%60))`

    echo "%{F$primary}$title%{F-} %{F$alt}|%{F-} %{F$primary}$artist%{F-} %{F$alt}|%{F-} %{F$primary}$album%{F-}  %{F$alt}|%{F-}  %{F$primary}$position%{F-} %{F$alt}|%{F-} %{F$primary}$timestamp%{F-}"
  }

  if [ "$(playerctl status 2>/dev/null)" = "Playing" ]; then
    elapsed=$(($elapsed + 1))
    update_cache

    echo "%{F$secondary}%{F-} $(get_info)"
  else
    echo "%{F$primary}%{F-} $(get_info)"
  fi

  sleep 1
done

echo ""
