# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{ pkgs, ...}:

{
  imports = [
    ../mac_base
  ];

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    # TODO - setup Firefox via NUR or flakes using: https://github.com/toonn/nix-config/blob/master/darwin/apps/firefox/default.nix
    # NOTE: Instructions related to NUR: https://github.com/nix-community/NUR#how-to-use
  ];

  # Setup core details for home-manager
  home.username = "test";
  home.homeDirectory = "/Users/test";
}
