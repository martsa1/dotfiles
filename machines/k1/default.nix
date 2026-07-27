{pkgs, lib, ...}: rec {
  imports = [
    # Pull in common setup.
    ../common

    # N.B. Can't import linux base as that has a bunch of GUI stuff in it I
    # don't want on the server.
  ];
  home.username = "sam";
  home.homeDirectory = "/home/sam";

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
  ];

  # Support fontconfig
  fonts.fontconfig.enable = true;

  # Enable GPGAgent
  # config file management
  xdg.enable = true;


  # Setup core details for home-manager
  home.stateVersion = "22.05";

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

    gpg = {
      enable = true;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
      grabKeyboardAndMouse = true;
    };
  };
}
