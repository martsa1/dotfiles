# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{outputs, pkgs, lib, ...}: {

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
    flameshot
    git
    iproute2mac
    uv


    postgresql
    pre-commit
    # python311

    spotify

  ];

  programs = {
    alacritty = {
      enable = true;
    };

    git = {
      settings = {
        user.name = lib.mkForce "Sam Martin-Brown";
        user.email = lib.mkForce "samuel.martin-brown@watchtowr.com";

        signing.signByDefault = true;

        # includes = [
        #   { path = "~/.config/git/work"; }
        # ];

        # ignores = [
        #   "tags"
        #   "shell.nix"
        #   "flake.nix"
        # ];


        extraConfig = {
          merge = {
            tool = "meld";
          };
        };
      };
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          identitiesOnly = true;
          forwardAgent = false;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPersist = "no";
        };
        # "github.com" = {
        #   identityFile = "~/.ssh/id_rsa.github";
        #   user = "git";
        # };
        "git.home" = {
          identityFile = "~/.ssh/id_rsa.github";
          user = "gitea";
        };
      };
      includes = ["config_work"];
    };
  };

  services = {
    # TODO: Can I add support for mac flameshot service similar to Linux?
    # flameshot = {
    #   enable = true;
    # };
  };

  nixpkgs.config = {
    allowUnfree = true;
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
