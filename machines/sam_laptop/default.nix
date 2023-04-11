{ pkgs, ... }:

{
  imports = [
    ../linux_base
  ];

  home.username = "sam";
  home.homeDirectory = "/home/sam";

  home.packages = with pkgs; [
    youtube-dl
    tartube
    ffmpeg
    vlc
    steam
  ];

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "gb";
    options = [ "ctrl:nocaps" ];
  };
}
