# Default Aliases that I tend to make use of

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# More ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Safer RM handling than standard.  Provides recovery options from terminal rm
alias rm=trash

# Git related Aliases
alias gs='git status'
alias gb='git branch -vv'

alias wip='git commit -a -m WIP'
alias squish='git status && git commit -a --amend -C HEAD'

# Autojump Autostart..
. /usr/share/autojump/autojump.sh

# Add a shortcut for Docker-Compose
alias dc='docker-compose' && complete -F _docker_compose dc
alias dlf='docker logs --follow'
alias dm='docker-machine'

alias tmx="tmux -L mysocket -S /home/${USER}/.tmux_sockets/mysocket"

alias monoterm="dbus-send --session /net/sf/roxterm/Options net.sf.roxterm.Options.SetProfile string:$ROXTERM_ID string:monoterm"
alias codeterm="dbus-send --session /net/sf/roxterm/Options net.sf.roxterm.Options.SetProfile string:$ROXTERM_ID string:codeterm"
