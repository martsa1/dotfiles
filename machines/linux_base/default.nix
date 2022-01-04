# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{ config, pkgs, ...}:

let
  python_version = pkgs.python38;
  custom_pkgs = pkgs.callPackage ../../pkgs/all.nix {
    inherit config;
    inherit pkgs;
    python3=python_version;
  };
in

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  imports = [
    # Pull in common setup.
    ../common

    # Enable and manage tmux via home-manager
    ../../dotfiles/tmux
  ];

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    bpytop  # Not in common because its broken on mac.
    brightnessctl
    custom_pkgs.dunst-dracula-theme
    custom_pkgs.i3-config
    custom_pkgs.polybar-launcher
    custom_pkgs.polybar-spotify
    custom_pkgs.rofi-dracula-theme
    discord
    dracula-theme  # Not in common!
    firefox-devedition-bin
    flameshot
    gnome3.zenity
    gthumb
    mupdf
    okular
    prusa-slicer
    scrot
    signal-desktop
    spotify
    teams
    xclip
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xorg.xev
    xorg.xprop
    yubioath-desktop

    # Youtube stuff
    youtube-dl
    tartube
    ffmpeg
    #vlc  # Seemingly broken on Ubuntu under home-manager...?
  ];

  # Set system theme
  gtk = {
    iconTheme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    theme = {
      #package = pkgs.arc-theme;
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  programs = {
  };

  # Setup notifications
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };

  };

  # Setup rofi
  programs.rofi = {
    enable = true;
    pass.enable = true;
    #pass.extraConfig = '' '';

    #font = "";
    location = "center";
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ../../dotfiles/rofi/dracula.rasi;
    extraConfig = {
      matching = "fuzzy";
      max-history-size = 100;
      modi = "window,run,ssh,keys";
      show-icons = true;
      sidebar-mode = true;
      sort = true;
      sorting-method = "fzf";
    };
  };

  # Playerctl support
  services.playerctld.enable = true;

  # Polybar
  services.polybar = {
    enable = true;
    config = ../../dotfiles/polybar/config;
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

  # Enable GPGAgent
  programs.gpg.enable = true;
  services.gpg-agent ={
    enable = true;
    pinentryFlavor = "qt";
    grabKeyboardAndMouse = true;
  };

  # Udiskie daemon
  services.udiskie = {
    enable = true;
    tray = "always";
  };

  # Power Alert daemon
  services.poweralertd.enable = true;

  # File setup for various RC/Config files etc.
  home.file = {
    #".tmux.conf".source = ../../dotfiles/tmux/tmux.conf;
    ".background-image".source = ../../backgrounds/pexels-pixabay-220072.jpg;
  };

  # config file management
  xdg.enable = true;
  xdg.configFile = {
    "i3/config".source = "${custom_pkgs.i3-config}/config";
    "i3/config".onChange = "i3-msg restart && systemctl --user restart polybar";

    "gtk-3.0/settings.ini".source = ../../dotfiles/gtk/settings.ini;

    "dunst/dunstrc".source = "${custom_pkgs.dunst-dracula-theme}/dunstrc";
  };

  # Attempt to sort out x Session.
  xsession.enable = true;
  xsession.windowManager.command = "i3";
}

