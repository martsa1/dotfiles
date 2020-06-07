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
    custom_pkgs.polybar-spotify
    discord
    docker-compose
    firefox-devedition-bin
    flameshot
    git-lfs
    gitAndTools.delta
    jq
    meld
    playerctl
    pstree
    rofi
    rofi-pass
    scrot
    signal-desktop
    spotify
    universal-ctags
    vifm
    xclip
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xorg.xev
    xorg.xprop
    yubioath-desktop
    unstable_pkgs.zplug
    # zsh
  ];

  programs.zsh.enable = true;
  # programs.zsh.zplug.enable = true;

  # Ensure ZSH setup pulls in my dotfiles stuff...
  programs.zsh.initExtra = ''
    if [ -f "$HOME/code/personal/dotfiles/zsh/zshrc" ]; then
      source "$HOME/code/personal/dotfiles/zsh/zshrc"
    fi
  '';
}
