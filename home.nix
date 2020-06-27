{ pkgs, ...}:

let
  # unstable_pkgs = import <nixpkgs-unstable> {};
  unstable_pkgs = import (
    fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
  ) {};

  python_version = pkgs.python38;
  custom_pkgs = pkgs.callPackage ./pkgs/all.nix { inherit pkgs; python3=python_version; };
in

{
  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    alacritty
    bat
    custom_pkgs.awscli
    custom_pkgs.polybar-launcher
    custom_pkgs.polybar-spotify
    discord
    docker-compose
    firefox-devedition-bin
    flameshot
    git-lfs
    gitAndTools.delta
    jq
    meld
    pass
    playerctl
    pstree
    rofi
    rofi-pass
    scrot
    signal-desktop
    spotify
    universal-ctags
    unstable_pkgs.zplug
    vifm
    xclip
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xorg.xev
    xorg.xprop
    yubioath-desktop
    # zsh
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = false;

    # Ensure ZSH setup pulls in my dotfiles stuff...
    initExtra = ''
      if [ -f "$HOME/.config/nixpkgs/dotfiles/zsh/zshrc" ]; then
        source "$HOME/.config/nixpkgs/dotfiles/zsh/zshrc"
      fi
    '';
  };

  # Setup notifications
  services.dunst.enable = true;

  # Polybar
  services.polybar = {
    enable = true;
    config = ./dotfiles/polybar/config;
    package = pkgs.polybarFull;
    script = ''
      export HOME=/home/sam
      export DISPLAY=:0
      export PATH=/run/wrappers/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin
      IFS=$'\n'
      for line in $(polybar-launcher --no-kill --echo-only)
      do
        eval "$line"
      done
      unset IFS
    '';
  };

  # Enable FZF
  programs.fzf.enable = true;

  # Enable and manage tmux via home-manager
  programs.tmux = {
    enable = true;
    # extraConfig = readFile ./dotfiles/tmux/tmux.conf;
  };

  # File setup for various RC/Config files etc.
  home.file = {
    ".tmux.conf".source = ./dotfiles/tmux/tmux.conf;
  };
}
