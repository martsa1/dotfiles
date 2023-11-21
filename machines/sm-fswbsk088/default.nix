{
  config,
  pkgs,
  ...
}: let
  glPkgs = import <nixgl> {};
in {
  imports = [
    ../linux_base
  ];

  home.packages = with pkgs; [
    #evolutionWithPlugins  # Can't use this outside of actual nixos it seems...
    arandr
    awscli2
    clang-tools_16 # C++ stuff for work...
    cmake-language-server
    deja-dup
    duplicity
    ffmpeg
    font-manager
    glPkgs.nixGLIntel
    globalprotect-openconnect
    google-chrome
    gp-saml-gui
    i3lock
    imv
    iputils
    kdiff3
    less
    miller
    neovide
    ninja
    nodePackages.typescript-language-server
    #nodejs_latest # no getting away from node...
    nodejs_18 # no getting away from node...
    obsidian
    openconnect
    podman
    poetry
    #postman
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
    yq
    xdg-utils
    xdotool
    #xq  - Bundled with yq??
  ];

  # Set a state version (determines various stateful bits and pieces. Should
  # try to update from time to time (Stuff may break)
  home.stateVersion = "22.05";

  # Username/homedir to reference in various bits of home manager - no default
  # provided as of stateVersion > 20.09.
  home.username = "sam";
  home.homeDirectory = "/home/sam";

  # Support fontconfig
  fonts.fontconfig.enable = true;

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "gb";
    options = ["ctrl:nocaps"];
  };

  # Attempt to ensure home-manager uses latest available nix version
  nix.package = pkgs.nix;

  home.shellAliases = {
    docker = "podman";
  };

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
      includes = ["$HOME/.ssh/config_work"];
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
}
