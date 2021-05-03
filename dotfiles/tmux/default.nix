{ pkgs, ...}:

{
programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 10;
    keyMode = "vi";
    historyLimit = 10000;


    plugins = with pkgs.tmuxPlugins; [
      # sensible
      yank
      copycat
      resurrect
      onedark-theme
      # TODO - Find out why this doesn't work
      #dracula
      #{
      #  plugin = dracula;
      #  extraConfig = ''
      #    set -g @dracula-show-battery false
      #    set -g @dracula-show-powerline true
      #    set -g @dracula-refresh-rate 10
      #  '';
      #}
    ];
     # extraConfig = builtins.readFile ./dotfiles/tmux/tmux.conf;
  };
}
