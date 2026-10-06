/*
vim: set filetype=nix ts=2 sw=2 tw=0 et :
*/
# Sams rofi setup: launcher config, Dracula theme, and the rofi-adjacent
# tooling (rofi-rbw plus its xdotool typer, rofimoji plus its config,
# rofi-calc, and the repo-overlay dracula rofi theme). Off by default; Linux
# machines opt in with `sm.rofi.enable = true;`.
{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.sm.rofi;
in {
  options.sm.rofi = {
    enable = lib.mkEnableOption "Sams rofi config and rofi-adjacent tooling";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rofi-rbw
      rofimoji
      rofi-dracula-theme
      xdotool # rofi-rbw typer on X11
    ];

    # Setup rofi
    programs.rofi = {
      enable = true;
      theme = ../../dotfiles/rofi/dracula.rasi;
      settings = {
        # Numeric window position: center (top=2, right=4, bottom=6, left=8)
        location = 0;
        terminal = "${pkgs.alacritty}/bin/alacritty";
        combi-modes = "drun,run";
        matching = "fuzzy";
        max-history-size = 100;
        modi = "window,run,drun,ssh,keys";
        show-icons = true;
        sidebar-mode = true;
        sort = true;
        sorting-method = "fzf";
      };
      plugins = [pkgs.rofi-calc];
      # Emoji support handled via rofimoji
    };

    xdg.configFile."rofimoji.rc".text = "files = [emojis, latin-1_supplement]";
  };
}
