{ config, pkgs, ... }:

let
  glPkgs = import (<nixgl>) {};
in
{
  imports = [
    ../linux_base
  ];

  home.packages = with pkgs; [
    #evolutionWithPlugins  # Can't use this outside of actual nixos it seems...
    arandr
    clang-tools  # C++ stuff for work...
    deja-dup
    duplicity
    ffmpeg
    font-manager
    google-chrome
    glPkgs.nixGLIntel
    globalprotect-openconnect
    i3lock
    kdiff3
    less
    neovide
    nodejs_latest # no getting away from node...
    openconnect
    podman
    poetry
    postman
    remmina
    remmina
    vagrant
    virt-manager
    vlc
    xdg-utils
  ];

  # Set a state version (determines various stateful bits and pieces. Should
  # try to update from time to time (Stuff may break)
  home.stateVersion = "22.05";

  # Username/homedir to reference in various bits of home manager - no default
  # provided as of stateVersion > 20.09.
  home.username = "sam";
  home.homeDirectory = "/home/sam";


  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "gb";
    options = [ "ctrl:nocaps" ];
  };

  # Attempt to ensure home-manager uses latest available nix version
  nix.package = pkgs.nix;

  home.shellAliases = {
    docker = "podman";
  };

  # Setup autorandr profiles
  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        "notify-i3" = "${pkgs.i3}/bin/i3-msg -s /run/user/1000/i3/ipc-socket.* restart && ${pkgs.systemd}/bin/systemctl --user restart polybar";
        "change-background" = "${pkgs.feh}/bin/feh --bg-scale ~/.background-image";
        "notify-user" = "${pkgs.libnotify}/bin/notify-send -i display 'Display profile changed:' $AUTORANDR_CURRENT_PROFILE";
      };
    };
  };

  # Setup syncthing to pull over old machines stuff.
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  # Seemingly needed for work machine to find all ZSH aliases, see here for more:
  # https://github.com/nix-community/home-manager/issues/2562#issuecomment-1009381061
  programs.zsh.initExtraBeforeCompInit = ''
    fpath+=("${config.home.profileDirectory}"/share/zsh/site-functions "${config.home.profileDirectory}"/share/zsh/$ZSH_VERSION/functions "${config.home.profileDirectory}"/share/zsh/vendor-completions)
  '';

  # Do magic when not on NixOS
  targets.genericLinux.enable = true;

  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 8;
  };
}
