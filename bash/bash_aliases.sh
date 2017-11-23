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

# Add a shortcut for Docker-Compose
alias dc='docker-compose' && complete -F _docker_compose dc
alias dlf='docker logs --follow'
alias dm='docker-machine'

alias tmx="tmux -L mysocket -S /home/${USER}/.tmux_sockets/mysocket"

alias monoterm="dbus-send --session /net/sf/roxterm/Options net.sf.roxterm.Options.SetProfile string:$ROXTERM_ID string:monoterm"
alias codeterm="dbus-send --session /net/sf/roxterm/Options net.sf.roxterm.Options.SetProfile string:$ROXTERM_ID string:codeterm"

alias ipython="ipython --TerminalInteractiveShell.editing_mode=vi"
alias python_tags=$'ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags $(python -c "import os, sys; print(\' \'.join(\'{}\'.format(d) for d in sys.path if os.path.isdir(d)))")'

if [ -f ~/.config/bash_work.sh ]; then
    . ~/.config/bash_work.sh
fi

# Add some paging related aliases for use when inside tmux, as the tmux moude mode fucks with them by default
declare -a tmux_unscrollables=('less' 'more' 'man')

function tmux_scrollable() {
  echo "tmux_scrollable called with arguments: ${*}"
  tmux_command=$1;
  shift;
  if [[ "${TMUX}" != '' ]]; then
    $(tmux set -g mouse off) && $tmux_command $* && $(tmux set -g mouse on);
  else
    echo "Executing ${tmux_command}, with arguments: ${*}"
    $tmux_command $*
  fi
}

for item in "${tmux_unscrollables[@]}"; do
  alias t$item="tmux_scrollable $item"
done;
