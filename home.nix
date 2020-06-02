{ pkgs, ...}:

let
  python_version = pkgs.python38;
  custom_pkgs = pkgs.callPackage ./pkgs/all.nix { inherit pkgs; python3=python_version; };
in

{
  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    alacritty
    bat
    custom_pkgs.awscli
    custom_pkgs.polybar-spotify
    discord
    docker-compose
    firefox
    flameshot
    git-lfs
    gitAndTools.delta
    jq
    meld
    playerctl
    pstree
    rofi
    rofi-pass
    scrot
    signal-desktop
    spotify
    universal-ctags
    vifm
    xclip
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xorg.xev
    xorg.xprop
    yubioath-desktop
  ];
}
