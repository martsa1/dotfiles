# Open an editor from the command mode
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

