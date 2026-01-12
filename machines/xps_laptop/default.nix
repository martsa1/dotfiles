{pkgs, lib, outputs, ...}: rec {
  imports = [
    ../linux_base
    outputs.homeModules.sm-ssh
  ];

  home.username = "sam";
  home.homeDirectory = "/home/sam";

  sm-ssh.enable = true;

  smi3config = {
    enable = true;
    hostname = "xps-laptop";
    username = home.username;
  };

  # Setup core details for home-manager
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    ffmpeg
    prusa-slicer
    steam
    teams-for-linux
    # tartube
    vlc
    yubioath-flutter
  ];

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "gb";
    options = ["ctrl:nocaps"];
  };

  programs = {
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
