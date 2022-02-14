# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{ pkgs, ...}:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  imports = [
    ../common
  ];

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    # TODO - setup Firefox via NUR or flakes using: https://github.com/toonn/nix-config/blob/master/darwin/apps/firefox/default.nix
    # NOTE: Instructions related to NUR: https://github.com/nix-community/NUR#how-to-use
  ];

  # Setup any mac specific programs here...
  programs = {
    # Enable GPG - no agent is supported on mac (guess it uses keychain instead?)
    gpg.enable = true;
  };

  # File setup for various RC/Config files etc.
  home.file = {
    #".tmux.conf".source = ../../dotfiles/tmux/tmux.conf;
    ".background-image".source = ../../backgrounds/pexels-pixabay-220072.jpg;
    ".terminfo/61".source = pkgs.alacritty.terminfo.outPath + "/share/terminfo/61";
    ".terminfo/a".source = pkgs.alacritty.terminfo.outPath + "/share/terminfo/a";
  };
}
