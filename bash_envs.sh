# Editor Settings
export EDITOR=nvim
export NVIM_CONFIG_BASE="${HOME}/code/personal/nvim"

# NodeJS path addition
export PATH=$PATH:~/.node/bin

# Ensure local python packages are on path
export PATH=$PATH:~/.local/bin

#Set the Go Path to ~/Coding/go
export GOPATH=$HOME/Coding/go
export PATH=$PATH:$GOPATH/bin

# Setup the powerline daemon for use with tmux etc.
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /home/sam/.local/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh


#Python VirtualEnv Settings
export WORKON_HOME=~/.python
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
. ~/.local/bin/virtualenvwrapper.sh

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Set the history verification, so that !, !! & !? put the command on the
# terminal line, rather than blindly executing it.
shopt -s histverify

# Rebind the terminal stop keybind so that we can use ^s to search forward
# in history
stty stop ^J
