# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{ config, pkgs, ... }:

{

  home.username = "sam";
  home.homeDirectory = "/home/sam";
  home.stateVersion = "22.05";

  imports = [
    # Pull in common setup.
    ../common

    # N.B. Can't import linux base as that has a bunch of GUI stuff in it I
    # don't want on the server.
  ];

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
  ];

  # Support fontconfig
  fonts.fontconfig.enable = true;

  # Enable GPGAgent
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    #pinentryFlavor = "qt";
    grabKeyboardAndMouse = true;
  };

  # config file management
  xdg.enable = true;

  # Enable Lorri.
  services.lorri.enable = true;
}


