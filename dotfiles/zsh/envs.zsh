# If we're not on NixOS, we should set NIX_PATH, see https://github.com/NixOS/nix/issues/2033
if [ ! -z NIX_PATH ]; then
  export NIX_PATH="$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"
fi

# Setup home-manager session variables, if they exist.
if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi


# Prompt for a password using Zenity
export SUDO_ASKPASS="${HOME}/.config/nixpkgs/dotfiles/i3/scripts/password_prompt.sh"
# Editor Settings
export EDITOR=nvim
export SHELL=$(which zsh)
#Sets nvim's default colourscheme to Dracula
export VAMPIRE=1
export NVIM_CONFIG_BASE="${HOME}/.config/nvim"

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


#Python VirtualEnv Settings
export WORKON_HOME=~/.python
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
[ -f ~/.local/bin/virtualenvwrapper_lazy.sh ] && source ~/.local/bin/virtualenvwrapper_lazy.sh

# Rebind the terminal stop keybind so that we can use ^s to search forward
# in history
#stty stop ^J

# Start Autojump - quicker directory navigation
[ -f /usr/share/autojump/autojump.zsh ] && source /usr/share/autojump/autojump.zsh
[ -f /run/current-system/sw/share/zsh/site-functions/autojump.zsh ] && source /run/current-system/sw/share/zsh/site-functions/autojump.zsh

# Put a timestamp into my bash history
export HISTTIMEFORMAT="%d/%m/%y %T "

# Put ZPLUG under ~/.config/zplug
export ZPLUG_HOME="$HOME/.config/zplug"

# Use ~/.config/nixpkgs/dotfiles/zsh/zplug.zsh for plugin definitions etc.
export ZPLUG_LOADFILE="$HOME/.config/nixpkgs/dotfiles/zsh/zplug.zsh"

# Use FZF if its available
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
if [ -f "$HOME/.nix-profile/share/fzf/key-bindings.zsh" ]; then
  source "$HOME/.nix-profile/share/fzf/key-bindings.zsh"
  source "$HOME/.nix-profile/share/fzf/completion.zsh"
fi


# Setup environment variables needed for pyenv
export PYENV_ROOT="$HOME/.config/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

if command -v pyenv 1>/dev/null 2>&1; then
  local PYTHON_VERSION=$(pyenv global | sed -n 's/.*\(3\..\).*/\1/p')
else
  local PYTHON_VERSION=$($(which python) --version 2>/dev/null | sed -n 's/.*\(3\..\).*/\1/p')
fi

eval "$(command pyenv init --path)"

#pyenv () {
#  unset -f pyenv
#  if [[ ! -n $VIRTUAL_ENV ]]; then
#    eval "$(command pyenv init --path)"
#  fi
#  pyenv $@
#}

#pip () {
#  unset -f pip
#  if [[ ! -n $VIRTUAL_ENV ]]; then
#    eval "$(command pyenv init --path)"
#  fi
#  pip $@
#}

#python () {
#  unset -f python
#  if [[ ! -n $VIRTUAL_ENV ]]; then
#    eval "$(command pyenv init --path)"
#  fi
#  python $@
#}

#poetry () {
#  unset -f poetry
#  if [[ ! -n $VIRTUAL_ENV ]]; then
#    eval "$(command pyenv init --path)"
#  fi
#  poetry $@
#}

## Enable Pipenv Completions
#pipenv () {
#  unset -f pipenv
#  if [[ ! -n $VIRTUAL_ENV ]]; then
#    eval "$(command pyenv init --path)"
#    eval "$(pipenv --completion)"
#  fi
#  pipenv $@
#}


# Only initialise powerline stuff for interactive shells, skip this for scripts etc.
if [[ -o interactive ]]; then
  # Setup the powerline daemon for use with tmux etc.
  powerline-daemon -q


  # Variable 'powerline_config_path' set in home-manager config, rather than here.
  if [ -f "$powerline_config_path" ]; then
    source "$powerline_config_path"

  elif [ -f "$HOME/.local/pipx/venvs/powerline-status/lib/python$PYTHON_VERSION/site-packages/powerline/bindings/zsh/powerline.zsh" ]; then
    powerline_script="$HOME/.local/pipx/venvs/powerline-status/lib/python$PYTHON_VERSION/site-packages/powerline/bindings/zsh/powerline.zsh"
    source  $powerline_script

  elif [ -f "$HOME/.local/venvs/powerline-status/lib/python$PYTHON_VERSION/site-packages/powerline/bindings/zsh/powerline.zsh" ]; then
    powerline_script="$HOME/.local/venvs/powerline-status/lib/python$PYTHON_VERSION/site-packages/powerline/bindings/zsh/powerline.zsh"
    source  $powerline_script

  # Installed on Nix-OS..
  elif [ -f "/run/current-system/sw/lib/python$PYTHON_VERSION/site-packages/powerline/bindings/zsh/powerline.zsh" ]; then
    source "/run/current-system/sw/lib/python$PYTHON_VERSION/site-packages/powerline/bindings/zsh/powerline.zsh"
  fi
fi

# Enable Better Exceptions in python code
export BETTER_EXCEPTIONS=1

# NVM settings
# placeholder nvm shell function
# On first use, it will set nvm up properly which will replace the `nvm`
# shell function with the real one
function nvm() {
  if command -v nvm 1>/dev/null 2>&1; then
    export NVM_DIR="$HOME/.nvm"
    # shellcheck disable=SC1090
    source "${NVM_DIR}/nvm.sh"
    if [[ -e ~/.nvm/alias/default ]]; then
      PATH="${PATH}:${HOME}.nvm/versions/node/$(cat ~/.nvm/alias/default)/bin"
    fi
    # invoke the real nvm function now
    nvm "$@"
  else
    echo "nvm is not installed" >&2
    return 1
  fi
}

# Add RBenv to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rbenv/bin"
function rbenv() {
  if command -v rbenv 1>/dev/null 2>&1; then
    unset -f rbenv
    eval "$(rbenv init -)"
    rbenv "$@"
  else
    echo "rbenv is not installed" >&2
    return 1
  fi
}

function ruby() {
  unset -f ruby
  eval "$(rbenv init -)"
  ruby "$@"
}

function fpm() {
  unset -f fpm
  eval "$(rbenv init -)"
  fpm "$@"
}

# gpg-agent wants this set:
export GPG_TTY=$(tty)
