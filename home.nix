# vim: set filetype=nix ts=2 sw=2 tw=0 et :
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
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  imports = [
    # Enable and manage tmux via home-manager
    ./dotfiles/tmux
  ];

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    bat
    brightnessctl
    bpytop
    #custom_pkgs.awscli
    custom_pkgs.dunst-dracula-theme
    custom_pkgs.i3-config
    custom_pkgs.polybar-launcher
    custom_pkgs.polybar-spotify
    discord
    docker-compose
    firefox-devedition-bin
    flameshot
    jq
    lsd
    meld
    mupdf
    pass
    pstree
    scrot
    signal-desktop
    spotify
    tldr
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
  ];

  # Set system theme
  gtk = {
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };

    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh.enable = false;

      # Ensure ZSH setup pulls in my dotfiles stuff...
      initExtra = ''
        if [ -f "$HOME/.config/nixpkgs/dotfiles/zsh/zshrc" ]; then
          source "$HOME/.config/nixpkgs/dotfiles/zsh/zshrc"
        fi
      '';
    };
    alacritty = {
      enable = true;
    };
    neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      extraPackages = [ pkgs.gcc ];
      viAlias = false;
    };


    git = {
      enable = true;

      userName = "Sam Martin-Brown";
      userEmail = "Nivekkas@gmail.com";

      delta.enable = true;
      delta.options = {
        line-numbers = true;
      };

      signing.signByDefault = true;
      signing.key = "61CB737879759A958B6B886626E45D5144EF59EA";

      aliases = {
        d = "diff";
      };

      ignores = [
        "tags"
      ];
    };
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
    fullscreen = false;
    lines = 15;
    location = "center";
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./dotfiles/rofi/dracula.rasi;
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

  # Enable GPGAgent
  programs.gpg.enable = true;
  services.gpg-agent ={
    enable = true;
    pinentryFlavor = "qt";
    grabKeyboardAndMouse = true;
  };

  # File setup for various RC/Config files etc.
  home.file = {
    #".tmux.conf".source = ./dotfiles/tmux/tmux.conf;
    ".background-image".source = ./backgrounds/pexels-pixabay-220072.jpg;
  };

  # config file management
  xdg.enable = true;
  xdg.configFile = {
    "i3/config".source = "${custom_pkgs.i3-config}/config";
    "i3/config".onChange = "i3-msg restart && systemctl --user restart polybar";

    "gtk-3.0/settings.ini".source = ./dotfiles/gtk/settings.ini;

    "alacritty/alacritty.yml".source = ./dotfiles/alacritty/alacritty.yml;

    "nvim/init.vim".source = ./nvim/config/standalone.vim;

    "dunst/dunstrc".source = "${custom_pkgs.dunst-dracula-theme}/dunstrc";
  };

  # Attempt to sort out x Session.
  xsession.enable = true;
  xsession.windowManager.command = "i3";
}
