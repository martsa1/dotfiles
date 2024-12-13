{
  config,
  inputs,
  pkgs,
  ...
}: rec {
  imports = [
    ../linux_base
  ];

  home.packages = with pkgs; [
    #evolutionWithPlugins  # Can't use this outside of actual nixos it seems...
    #nodejs_latest # no getting away from node...
    #postman
    #xq  - Bundled with yq??
    arandr
    awscli2
    clang-tools_16 # C++ stuff for work...
    cmake-language-server
    deja-dup
    duplicity
    evolution
    ffmpeg
    font-manager
    gitg
    gittyup
    # globalprotect-openconnect
    go-task
    google-chrome
    gp-saml-gui
    i3lock
    imv
    iputils
    jfrog-cli
    kdiff3
    less
    miller
    neovide
    ninja
    nix-output-monitor
    nixgl.nixGLIntel
    nodePackages.typescript-language-server
    nodejs_18 # no getting away from node...
    nomacs
    obsidian
    openconnect
    pinentry-qt
    podman
    poetry
    remmina
    remmina
    rsync
    ruff
    ruff-lsp
    rustup
    tree
    vagrant
    virt-manager
    vlc
    vscode
    vscode-langservers-extracted
    inputs.wezterm.packages.${pkgs.system}.default
    uv
    xdg-utils
    xdotool
    yq
  ];

  # Set a state version (determines various stateful bits and pieces. Should
  # try to update from time to time (Stuff may break)
  home.stateVersion = "22.05";

  # Username/homedir to reference in various bits of home manager - no default
  # provided as of stateVersion > 20.09.
  home.username = "sam";
  home.homeDirectory = "/home/sam";

  smi3config = {
    enable = true;
    hostname = "fswbsk088";
    username = home.username;
  };

  # Support fontconfig
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [
        "OpenMoji Color"
      ];
      monospace = [
        "Fira Mono"
        "Font Awesome 5 Free"
        "Font Awesome 5 Brands"
        "Noto Mono"
      ];
      sansSerif = [
        "Fira Sans"
        "Liberation Sans"
      ];
    };
  };

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "gb";
    options = ["ctrl:nocaps"];
  };

  # Attempt to ensure home-manager uses latest available nix version
  nix.package = pkgs.nix;

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = pkgs.lib.optional (pkgs.obsidian.version == "1.5.3") "electron-25.9.0";
  };

  # home.shellAliases = {
  #   docker = "podman";
  # };

  programs = {
    # Setup autorandr profiles
    autorandr = {
      enable = true;
      hooks = {
        postswitch = {
          "notify-i3" = "${pkgs.i3}/bin/i3-msg -s /run/user/1000/i3/ipc-socket.* restart && ${pkgs.systemd}/bin/systemctl --user restart polybar.service";
          "change-background" = "${pkgs.feh}/bin/feh --bg-scale ~/.background-image";
          "notify-user" = "${pkgs.libnotify}/bin/notify-send -i display 'Display profile changed:' $AUTORANDR_CURRENT_PROFILE";
          "bounce-picom" = "${pkgs.systemd}/bin/systemctl --user restart picom.service";
        };
      };
    };

    # Certain programs are started with `/bin/bash program`, which means if I only have ZSH setup,
    # these programs won't have the correct sessionVariables present
    bash.enable = true;

    # Machine specific overrides to that in common
    git = {
      userName = "Sam Martin-Brown";
      userEmail = pkgs.lib.mkForce "sam.martin@withsecure.com";

      signing.signByDefault = true;
      # Setting this option might override default signing key selection...?
      #signing.key = "61CB737879759A958B6B886626E45D5144EF59EA";
      signing.key = null;
    };

    ssh = {
      enable = true;
      includes = ["config_work"];
      matchBlocks = {
        "*" = {
          identitiesOnly = true;
        };
        "github.com" = {
          identityFile = "~/.ssh/id_rsa.github";
          user = "git";
        };
      };
    };

    # Seemingly needed for work machine to find all ZSH aliases, see here for more:
    # https://github.com/nix-community/home-manager/issues/2562#issuecomment-1009381061
    zsh = {
      initExtraBeforeCompInit = ''
        fpath+=("${config.home.profileDirectory}"/share/zsh/site-functions "${config.home.profileDirectory}"/share/zsh/$ZSH_VERSION/functions "${config.home.profileDirectory}"/share/zsh/vendor-completions)
      '';
      initExtra = "setopt monitor";
    };
  };

  services = {
    picom = {
      enable = true;
      fade = true;
      fadeDelta = 8;
    };

    ssh-agent = {
      enable = true;
    };

    # Setup syncthing to pull over old machines stuff.
    syncthing = {
      enable = false;
      tray.enable = false;
    };

    # Udiskie for easy external disk usage...
    udiskie = {
      enable = true;
    };
  };

  # Do magic when not on NixOS
  targets.genericLinux.enable = true;

  xdg.configFile = {
    "i3/scripts".source = ../../dotfiles/i3/scripts;
  };

  # Enable GPGAgent
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry;
    grabKeyboardAndMouse = true;
  };

  # Enable XDG portal
  xdg.portal = {
    enable = true;
    # config = {
    #   common = {
    #     default = [
    #       "gtk"
    #     ];
    #   };
    # };
    configPackages = [ pkgs.xdg-desktop-portal-gtk ];
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    xdgOpenUsePortal = true;
  };

  # File setup for various RC/Config files etc.
  home.file = {
    # "bin/docker" = {
    #   executable = true;
    #   source = "${pkgs.podman}/bin/podman";
    # };
  };
}
