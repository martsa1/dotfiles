# zplug definitions for extensions to ZSH

# Allow Zplug to manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Adds "k" - A super sexy directory listing tool.
zplug "supercrabtree/k"

# Add a shitload of completions for far more than I can think of...
zplug "zsh-users/zsh-completions"

# Add support for pip completion
zplug "srijanshetty/zsh-pip-completion"

# ZSH Syntax Highlighting
zplug "zdharma/fast-syntax-highlighting", defer:2

# ZPlug auto notify
zplug "MichaelAquilina/zsh-auto-notify"
