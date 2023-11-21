# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Pull in common setup.
    ../common
  ];

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    btop # Not in common because its broken on mac.
    brightnessctl
    discord
    dracula-theme # Not in common!
    feh
    firefox-devedition-bin
    gnome.zenity
    gthumb
    i3
    killall
    lua-language-server
    mupdf
    okular
    pavucontrol
    peek
    playerctl
    #prusa-slicer
    rofimoji
    scrot
    shellcheck
    signal-desktop
    #slack
    spotify
    # teams
    xclip
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.xfconf
    xorg.xev
    xorg.xkill
    xorg.xprop
    xorg.xrandr
    #yubioath-desktop
    yubikey-manager

    # My packages:
    dunst-dracula-theme
    i3-config
    polybar-launcher
    polybar-spotify
    rofi-dracula-theme
  ];

  # Support fontconfig
  fonts.fontconfig.enable = true;

  # Set system theme
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.dracula-theme;
      name = "dracula";
      #package = pkgs.arc-icon-theme;
      #name = "Arc";
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
  home.pointerCursor = {
    package = pkgs.dracula-theme;
    name = "Dracula-cursors";
    x11.enable = true;
    gtk.enable = true;
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
      combi-modes = "drun,run";
      matching = "fuzzy";
      max-history-size = 100;
      modi = "window,run,drun,ssh,keys";
      show-icons = true;
      sidebar-mode = true;
      sort = true;
      sorting-method = "fzf";
    };
    plugins = [pkgs.rofi-calc];
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
        MONITOR=$mon polybar --config="$HOME/.config/polybar/config.ini" --reload secondary &
      done

      MONITOR=$primary polybar --config="$HOME/.config/polybar/config.ini" --reload primary &
    '';
  };

  # autorandr
  programs.autorandr = {
    enable = true;
  };
  services.autorandr = {
    enable = true;
  };

  # Enable GPGAgent
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    #pinentryFlavor = "qt";
    grabKeyboardAndMouse = true;
  };

  # Setup z-lua
  programs.z-lua = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = true;
    enableFishIntegration = false;
  };

  # Udiskie daemon
  services.udiskie = {
    enable = true;
    tray = "always";
  };

  # Power Alert daemon
  services.poweralertd.enable = true;

  # Screen clipping
  services.flameshot.enable = true;

  # On linux systems, I tend to like to use meld for merge conflicts.
  programs.git = {
    extraConfig = {
      merge = {
        tool = "meld";
      };
    };
  };

  # File setup for various RC/Config files etc.
  home.file = {
    #".tmux.conf".source = ../../dotfiles/tmux/tmux.conf;
    ".background-image".source = ../../backgrounds/pexels-pixabay-220072.jpg;

    ".themes/Dracula".source = "${pkgs.dracula-theme.outPath}/share/themes/Dracula";
    ".icons/Dracula-cursors".source = "${pkgs.dracula-theme.outPath}/share/icons/Dracula-cursors";
    ".icons/Dracula".source = "${pkgs.gtk-dracula-icons}/Dracula";
  };

  # config file management
  xdg.enable = true;
  xdg.configFile = {
    "nixpkgs/config.nix".source = ../../config.nix;
    "i3/config".source = "${pkgs.i3-config}/config";
    "i3/config".onChange = "${pkgs.i3}/bin/i3-msg -s /run/user/1000/i3/ipc-socket.* restart && systemctl --user restart polybar";

    "dunst/dunstrc".source = "${pkgs.dunst-dracula-theme}/dunstrc";

    "rofimoji.rc".text = "files = [emojis, latin-1_supplement]";
  };

  # Attempt to sort out x Session.
  xsession.enable = true;
  xsession.windowManager.command = "i3";

  # Enable Lorri.
  services.lorri = {
    enable = true;
    enableNotifications = true;
  };
}
