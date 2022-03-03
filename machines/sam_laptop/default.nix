{ pkgs, ... }:

{
  imports = [
    ../linux_base
  ];

  home.packages = with pkgs; [
    youtube-dl
    tartube
    ffmpeg
    vlc
  ];

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "gb";
    options = [ "ctrl:nocaps" ];
  };
}
