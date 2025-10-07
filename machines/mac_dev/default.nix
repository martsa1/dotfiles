# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{outputs, pkgs, ...}: {

  imports = [
    ../mac_base
   outputs.homeModules.sm-aerospace
  ];

  sm-aerospace.enable = true;

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    # TODO - setup Firefox via NUR or flakes using: https://github.com/toonn/nix-config/blob/master/darwin/apps/firefox/default.nix
    # NOTE: Instructions related to NUR: https://github.com/nix-community/NUR#how-to-use
    btop
    git
    # poetry
    # niversal-ctags
    #ncdu
    # pkg-config
    uv
  ];

  programs = {
    alacritty = {
      enable = true;
    };

    ssh = {
      enable = true;
      includes = ["config_work"];
      matchBlocks = {
        "*" = {
          identitiesOnly = true;
        };
        "github.com" = {
          identityFile = "~/.ssh/id_ed25519.watchtowr";
          user = "git";
        };
        "git.home" = {
          identityFile = "~/.ssh/id_rsa.github";
          user = "gitea";
        };
      };
    };
  };
  # Setup core details for home-manager
  home.username = "samuel";
  home.homeDirectory = "/Users/samuel";

  home.file = {
    # Attempt to configure the GPG agent...
    ".gnupg/gpg-agent.conf" = {
      text = ''
        allow-loopback-pinentry
        pinentry-program "${pkgs.pinentry-curses}/bin/pinentry-curses"
      '';
    };
  };


}
