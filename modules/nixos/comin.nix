# Opinionated wrapper around the comin flake-input module.
#
# comin is a pull-based GitOps deployer: each host that enables this rebuilds
# its OWN nixosConfiguration when the watched branch changes (comin derives the
# hostname -> config mapping itself), so the same module config is shared across
# k1, laptop-server, and any future host. The comin input module is injected
# universally by mkNixos in flake.nix; this module only carries the shared,
# opinionated service settings.
{config, lib, ...}: let
  cfg = config.sm.comin;
in {
  options.sm.comin = {
    enable = lib.mkEnableOption "comin pull-based deploy from the dotfiles repo";
  };

  config = lib.mkIf cfg.enable {
    # Public HTTPS remote — comin needs no credentials as long as
    # martsa1/dotfiles stays public. If it goes private, configure a read
    # token on the remote.
    services.comin = {
      enable = true;
      remotes = [
        {
          name = "github";
          url = "https://github.com/martsa1/dotfiles.git";
          branches.main.name = "main";
        }
      ];
    };
  };
}
