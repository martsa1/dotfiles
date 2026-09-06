{pkgs, lib, outputs, inputs, ...}: rec {
  imports = [
    ../linux_base
    outputs.homeModules.ssh
  ];

  home.username = "sam";
  home.homeDirectory = "/home/sam";

  sm.ssh.enable = true;

  sm.i3-config = {
    enable = true;
    hostname = "xps-laptop";
    username = home.username;
  };

  # Setup core details for home-manager
  home.stateVersion = "22.05";

  # Wallpaper for the X session. NixOS' desktopManager.wallpaper module runs
  # `feh --bg-scale $HOME/.background-image` automatically for the none+i3
  # session, so we only need the image present at this fixed path. linux_base
  # sets a default image; mkForce overrides it for this machine.
  home.file.".background-image".source = lib.mkForce ../../backgrounds/pexels-kelly-lacy-2538504.jpg;

  home.packages = with pkgs; [
    android-tools
    bitwarden-desktop

    # tartube
    ffmpeg
    kubectl
    openspec
    prusa-slicer
    steam
    teams-for-linux
    vlc
    yubioath-flutter
    inputs.omp-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "gb";
    options = ["ctrl:nocaps"];
  };

  programs = {
    claude-code = {
      enable = true;
    };

    git = {
      settings = {
        user = {
          name = "Sam Martin-Brown";
          email = lib.mkForce "Nivekkas@gmail.com";
          };
      };

      signing.signByDefault = true;
      # Setting this option might override default signing key selection...?
      signing.key = lib.mkForce "61CB737879759A958B6B886626E45D5144EF59EA";
    };

    # Fiddle with kitty...
    kitty = {
      enable = true;
      font = {
        # name = "Fira Mono Nerd Font";
        # package = pkgs.nerd-fonts.fira-mono;
        name = "monospace";
        size = 9;
      };
      settings = {
        # https://sw.kovidgoyal.net/kitty/conf/
        scrollback_lines = 10000;

        enable_audio_bell = false;
        visual_bell_duration = "0.2";

        background_opacity = "0.8";
        background = "#282a36";
        foreground = "#f8f8f2";
      };
    };

    gpg = {
      enable = true;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      # Prefer to set this based off the runtime pinentry...?
      # I'd really prefer a GUI pop-up when local, but a curses one when remote?
      # pinentryFlavor = "qt";
      pinentry.package = pkgs.pinentry-all;
    };

    trayscale.enable = true;
  };
}
