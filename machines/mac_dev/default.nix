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
    # teams -- Fails to store login data for unknown reasons...
    # claude-agent-acp
    # cloudflare-warp  # This is the front-end only, needs the server component. Try with homebrew
    ast-grep
    awscli2
    bitwarden-cli
    btop
    claude-code
    code-cursor
    colima
    cursor-cli
    dbeaver-bin
    devcontainer
    docker
    dust
    flameshot
    gh
    git
    iproute2mac
    k9s
    kubectl
    kubernetes-helm
    mongodb-compass
    nmap
    notion-app
    postgresql
    pre-commit
    prek
    signal-desktop
    slack
    spotify
    ssm-session-manager-plugin
    terraform
    tree
    uv
    worktrunk
    yq
    zstd
  ];

  programs = {
    alacritty = {
      enable = true;
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-bin;

      policies = {
        AppAutoUpdate = false;
        BackgroundAppUpdate = false;

        DisablePocket = true;
        DisableTelemetry = true;

        GenerativeAI = {
          Enabled = false;
        };


        # Don't seem to work - but also don't really want to use arbitrary extra flake input
        # # see: https://wiki.nixos.org/wiki/Firefox/en
        # # and: https://mozilla.github.io/policy-templates/#extensionsettings
        # # keys in `ExtensionSettings` are the Extension "GUID", look that up like this:
        # # curl https://addons.mozilla.org/api/v5/addons/addon/{slug}/ | jq '.guid'
        # # where 'slug' is the name from the addons web-page (e.g. ublock-origin or vimium-ff etc.)
        # ExtensionSettings = let
        #   moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
        # in {
        #   "{7c4c19b9-2441-4942-873e-cb9eeee18a97}" = {
        #     install_url = moz "push-security";
        #     installation_mode = "force_installed";
        #   };
        #
        #   "uBlock0@raymondhill.net" = {
        #     install_url = moz "ublock-origin";
        #     installation_mode = "force_installed";
        #   };
        #
        #   "{b743f56d-1cc1-4048-8ba6-f9c2ab7aa54d}" = {
        #     install_url = moz "dracula-dark-colorscheme";
        #     installation_mode = "force_installed";
        #   };
        #
        #   "@testpiolot-containers" = {
        #     install_url = moz "multi-account-containers";
        #     installation_mode = "force_installed";
        #   };
        #
        #   "addon@darkreader.org" = {
        #     install_url = moz "darkreader";
        #     installation_mode = "force_installed";
        #   };
        #
        #   "treestyletab@piro.sakura.ne.jp" = {
        #     install_url = moz "tree-style-tab";
        #     installation_mode = "force_installed";
        #   };
        #
        #   "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
        #     install_url = moz "vimium-ff";
        #     installation_mode = "force_installed";
        #   };
        # };
      };

      profiles.default = {
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
        };

        # extensions.autoDisableScopes = 0;  # enable extensions by default
      };
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
      settings = {
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
