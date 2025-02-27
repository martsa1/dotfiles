{pkgs, ...}: rec {
  imports = [
    ../linux_base
  ];

  home.username = "sam";
  home.homeDirectory = "/home/sam";

  smi3config = {
    enable = true;
    hostname = "xps-laptop";
    username = home.username;
  };

  # Setup core details for home-manager
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    tartube
    ffmpeg
    vlc
    steam
  ];

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "gb";
    options = ["ctrl:nocaps"];
  };

  # Fiddle with kitty...
  programs.kitty = {
    enable = true;
    font = {
      name = "Fira Mono Nerd Font";
      package = pkgs.nerd-fonts.fira-mono;
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
}
