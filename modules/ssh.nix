# Config for mac Aerospace window manager tooling
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.sm-ssh;
in {
  options.sm-ssh = {
    enable = lib.mkEnableOption "Sams SSH client config";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      # Default Host * values are being removed from home-manager; inline the
      # former defaults here so the generated ~/.ssh/config is unchanged.
      enableDefaultConfig = false;
      settings = {
        "*" = {
          forwardAgent = false;
          addKeysToAgent = "no";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
          identitiesOnly = true;
        };

        "github.com" = {
          identityFile = "~/.ssh/id_rsa.github";
          user = "git";
        };

        "git.home" = {
          identityFile = "~/.ssh/id_rsa.github";
          user = "gitea";
        };

        "laptop-server.home" = {
          identityFile = "~/.ssh/id_rsa.abitmoredepth";
          user = "sam";
        };

        "k1.home" = {
          identityFile = "~/.ssh/id_rsa.abitmoredepth";
          user = "sam";
        };
      };
    };
  };
}

