{ config, pkgs, ... }:

{
  imports = [
    ./linux_base
  ];
  home.packages = with pkgs; [
    remmina
  ];

  # Seemingly needed for work machine to find all ZSH aliases, see here for more:
  # https://github.com/nix-community/home-manager/issues/2562#issuecomment-1009381061
  programs.zsh.initExtraBeforeCompInit = ''
    fpath+=("${config.home.profileDirectory}"/share/zsh/site-functions "${config.home.profileDirectory}"/share/zsh/$ZSH_VERSION/functions "${config.home.profileDirectory}"/share/zsh/vendor-completions)
  '';

  # Do magic when not on NixOS
  targets.genericLinux.enable = true;

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "us";
    options = [ "ctrl:nocaps" ];
    # To manually swap back to UK layout:
    # setxkbmap gb -option ctrl:nocaps (or run keyboard-gb)
  };
}
