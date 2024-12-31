{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    appimage-run
    arandr
    arc-icon-theme
    arc-theme
    autojump
    curl
    fd
    feh
    # firefox
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
    python3
    ripgrep
    tmux
    udiskie
    unzip
    vim
    virt-manager
    wget
    xorg.xkill
    # zenity
    zip
    zlib
    zsh
    # (neovim.override {
    #   vimAlias = true;
    # })
  ];
}
