# Editor Settings
export EDITOR=nvim
export SHELL=$(which zsh)
#Sets nvim's default colourscheme to Dracula
export VAMPIRE=1
export NVIM_CONFIG_BASE="${HOME}/code/personal/nvim"

# NodeJS path addition
export PATH=$PATH:~/.node/bin

# Ensure local python packages are on path
export PATH=$PATH:~/.local/bin

# Ensure various locally installed things are on the path
export PATH=$PATH:~/bin/

# Ensure Nix managed tooling is on PATH
export PATH=$PATH:~/.nix-profile/bin/

#Set the Go Path to ~/Coding/go
export GOPATH=$HOME/Coding/go
export PATH=$PATH:$GOPATH/bin

# Put Rust on the path
export PATH=$PATH:$HOME/.cargo/bin

# Setup the powerline daemon for use with tmux etc.
powerline-daemon -q
PYTHON_VERSION=$(python3 --version | sed -n 's/.*\(3\..\).*/\1/p')
powerline_script=~/.local/venvs/powerline-status/lib/python${PYTHON_VERSION}/site-packages/powerline/bindings/zsh/powerline.zsh
source  $powerline_script


#Python VirtualEnv Settings
export WORKON_HOME=~/.python
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source ~/.local/bin/virtualenvwrapper.sh

# Rebind the terminal stop keybind so that we can use ^s to search forward
# in history
#stty stop ^J

# Start Autojump - quicker directory navigation
source /usr/share/autojump/autojump.sh

# Make Whalebrew work with local bin, rather than a global one which requres root
export WHALEBREW_INSTALL_PATH="$HOME/bin"

# Put a timestamp into my bash history
export HISTTIMEFORMAT="%d/%m/%y %T "

# Put ZPLUG under ~/.config/zplug
export ZPLUG_HOME="$HOME/.config/zplug"

# Use ~/code/personal/dotfiles/zsh/zplug.zsh for plugin definitions etc.
export ZPLUG_LOADFILE="$HOME/code/personal/dotfiles/zsh/zplug.zsh"

# Pull in FZF for shell usage.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
