{ pkgs, ...}:

{

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    alacritty
    bat
    docker-compose
    discord
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
