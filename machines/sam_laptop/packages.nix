{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ansible
    appimage-run
    arandr
    arc-icon-theme
    arc-theme
    autojump
    curl
    fd
    feh
    git
    gitg
    gnupg
    # home-manager
    htop
    imagemagick
    killall
    libnotify
    lxappearance
    moka-icon-theme
    networkmanagerapplet
    # notify-osd
    pass
    pavucontrol
    pciutils
    # pinentry
    pinentry-qt
    playerctl
    polkit
    python37
    powerline
    ripgrep
    tmux
    udiskie
    unzip
    vim
    virt-manager
    wget
    xorg.xkill
    zip
    zlib
    zsh
  ];
}
