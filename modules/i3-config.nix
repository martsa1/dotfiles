# Config to generate i3config based on my slightly weird Python + Jinja setup...
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.smi3config;

  baseTemplate = ../../dotfiles/i3/base_config/config.j2;
  pactl = "${pkgs.pulseaudio.outPath}/bin/pactl";

in {
  options.smi3config = {
    enable = lib.mkEnableOption "Sams i3 config setup";

    hostname = lib.mkOption {
      type = lib.types.str;
      description = "Hostname to use when rendering i3 config.";
    };

    username = lib.mkOption {
      type = lib.types.str;
      description = "Username to use when rendering i3 config.";
    };
  };

  config = lib.mkIf cfg.enable {
    # xdg.configFile."i3/config_new".source = pkgs.runCommand "smi3config" {} ''
    #   ${pkgs.jinja2-cli}/bin/jinja2 ${baseTemplate} -D ansible_hostname=${cfg.hostname} > $out
    #   '';

    xdg.configFile."i3/config".source = (pkgs.stdenv.mkDerivation {
        pname = "sm-i3-configuration";
        version = "1.0.0";

        src = self/../../dotfiles/i3;

        # Disable all other steps.
        phases = "installPhase";

        buildInputs = [pkgs.jinja2-cli];

        installPhase = ''
          echo "i3-hostname set to: '${cfg.hostname}'"
          ${pkgs.jinja2-cli}/bin/jinja2 \
            $src/base_config/config.j2 \
            -D ansible_hostname=${cfg.hostname} \
            -D pactl=${pactl} \
            -D user=${cfg.username} \
            > $out
        '';
      }).out;
  };
}
