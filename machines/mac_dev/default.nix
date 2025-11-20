# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{outputs, pkgs, lib, ...}: {

  imports = [
    ../mac_base
   outputs.homeModules.sm-aerospace
  ];

  sm-aerospace.enable = true;

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    # _1password-gui  -- Fails detecting it's not installed in the right place...
    awscli2
    btop
    code-cursor
    colima
    docker
    flameshot
    git
    google-chrome
    iproute2mac
    notion-app
    postgresql
    pre-commit
    signal-desktop-bin
    slack
    spotify
    tree
    # teams -- Fails to store login data for unknown reasons...
    uv
    yq
  ];

  programs = {
    alacritty = {
      enable = true;
    };

    git = {
      settings = {
        user.name = lib.mkForce "Sam Martin-Brown";
        user.email = lib.mkForce "samuel.martin-brown@watchtowr.com";
        user.signingKey = lib.mkForce "39910AEC07E0F211";

        # signing.signByDefault = true;

        # includes = [
        #   {
        #     path = "/Users/samuel/.config/git/config_work";
        #     condition = null;
        #   }
        #   # "~/.config/git/config_work"
        # ];

        # ignores = [
        #   "tags"
        #   "shell.nix"
        #   "flake.nix"
        # ];


        # extraConfig = {
        #   merge = {
        #     tool = "meld";
        #   };
        # };
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
