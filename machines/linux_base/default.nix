# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{ config, pkgs, ... }:

let
  python_version = pkgs.python39;
  custom_pkgs = pkgs.callPackage ../../pkgs/all.nix {
    inherit config;
    inherit pkgs;
    python3 = python_version;
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
    bpytop # Not in common because its broken on mac.
    brightnessctl
    custom_pkgs.dunst-dracula-theme
    custom_pkgs.i3-config
    custom_pkgs.polybar-launcher
    custom_pkgs.polybar-spotify
    custom_pkgs.rofi-dracula-theme
    discord
    dracula-theme # Not in common!
    firefox-devedition-bin
    flameshot
    gnome3.zenity
    gthumb
    i3
    mupdf
    okular
    prusa-slicer
    rofimoji
    scrot
    signal-desktop
    slack
    spotify
    teams
    xclip
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.xfconf
    xorg.xev
    xorg.xprop
    xorg.xrandr
    yubioath-desktop

  ];

  # Set system theme
  gtk = {
    enable = true;
    iconTheme = {
      #package = pkgs.dracula-theme;
      #name = "Dracula";
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };

    theme = {
      #package = pkgs.arc-theme;
      #name = "Arc-Dark";
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    gtk2.extraConfig = ''
      gtk-cursor-theme-name="Dracula-cursors"
      gtk-cursor-theme-size=0
      gtk-button-images=0
      gtk-menu-images=0
      gtk-enable-event-sounds=1
      gtk-enable-input-feedback-sounds=1
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';

    gtk3.extraConfig = {
      gtk-button-images = 0;
      gtk-cursor-theme-name = "Dracula-cursors";
      gtk-enable-event-sounds = 1;
      gtk-enable-input-feedback-sounds = 1;
      gtk-menu-images = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
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
    pass.extraConfig = builtins.readFile ../../dotfiles/rofi/rofi-pass-config;

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
    plugins = [ pkgs.rofi-calc ];
    # Emoji support handled via rofimoji
  };

  # Playerctl support
  services.playerctld.enable = true;

  # Polybar
  services.polybar = {
    enable = true;
    config = ../../dotfiles/polybar/config;
    package = pkgs.polybarFull.override {
      i3Support = true;
    };
    script = ''
      set -x

      export HOME=/home/sam
      export DISPLAY=:0
      # export PATH=$HOME/.nix-profile/bin

      . /home/sam/.nix-profile/etc/profile.d/hm-session-vars.sh
      export PATH="${pkgs.ripgrep.outPath}/bin:$PATH"
      export PATH="${pkgs.xorg.xrandr.outPath}/bin:$PATH"
      export PATH="${pkgs.coreutils.outPath}/bin:$PATH"

      echo $PATH
      xrandr_out=$(xrandr)
      secondaries=$(echo "$xrandr_out" | rg connected | rg -v 'disconnected|primary' | cut -d ' ' -f 1)
      primary=$(echo "$xrandr_out" | rg 'connected.*primary' | cut -f 1 -d ' ')

      for mon in $secondaries; do
        MONITOR=$mon polybar --config="$HOME/.config/polybar/config" --reload secondary &
      done

      MONITOR=$primary polybar --config="$HOME/.config/polybar/config" --reload primary &
    '';
  };


  # autorandr
  programs.autorandr = {
    enable = true;
  };

  # Enable GPGAgent
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    #pinentryFlavor = "qt";
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

    ".themes/Dracula".source = "${pkgs.dracula-theme.outPath}/share/themes/Dracula";
    ".icons/Dracula-cursors".source = "${pkgs.dracula-theme.outPath}/share/icons/Dracula-cursors";
    ".icons/Dracula".source = "${custom_pkgs.gtk-dracula-icons}/Dracula";

    # Direnv rc for extra layouts
    ".direnvrc".source = ../../dotfiles/direnvrc;
  };

  # config file management
  xdg.enable = true;
  xdg.configFile = {
    "i3/config".source = "${custom_pkgs.i3-config}/config";
    "i3/config".onChange = "i3-msg restart && systemctl --user restart polybar";

    "dunst/dunstrc".source = "${custom_pkgs.dunst-dracula-theme}/dunstrc";

    "rofimoji.rc".text = "files = [emojis, latin-1_supplement]";
  };

  # Attempt to sort out x Session.
  xsession.enable = true;
  xsession.windowManager.command = "i3";
}

