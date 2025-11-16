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
      matchBlocks = {
        "*" = {
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

