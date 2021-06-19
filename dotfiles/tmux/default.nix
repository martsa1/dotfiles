/* vim: set filetype=nix ts=2 sw=2 tw=0 et :*/
{ pkgs, ...}:

{
programs.tmux = {
    enable = true;
    terminal = "alacritty";
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 10;
    keyMode = "vi";
    historyLimit = 10000;
    extraConfig = ''
      # Force Tmux to use 24bit colour
      set-option -sa terminal-overrides ",alacritty*:Tc"

      # Make Tmux highlight activity in other panes by defualt
      setw -g monitor-activity on
      # Allow swapping panes around
      bind-key -r "<" swap-window -t -1
      bind-key -r ">" swap-window -t +1

      # Jump to last used window
      bind-key "C-^" last-window
      bind-key 6 select-window -t :=6

      # Add key-binding to re-number windows in a tmux session
      bind-key "W" move-window -r

      # mouse control (clickable windows, resizable panes)
      set -g mouse on

      # Open new panes in current path by default
      bind-key "c" new-window -c "#{pane_current_path}"

      # reload config file
      bind r source-file ~/.tmux.conf


      # Make windows with changes easier to notice
      set-window-option -g window-status-bell-style "reverse"
      set-window-option -g window-status-activity-style "bold"
    '';


    plugins = with pkgs.tmuxPlugins; [
      yank
      copycat
      resurrect
      #onedark-theme
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery true
          set -g @dracula-show-network false
          set -g @dracula-show-weather false
          set -g @dracula-show-fahrenheit false
          set -g @dracula-show-location false
          set -g @dracula-show-powerline true
          set -g @dracula-show-flags true
          set -g @dracula-show-left-icon session
          set -g @dracula-left-icon-padding 1
          set -g @dracula-military-time true
          set -g @dracula-show-timezone true
          set -g @dracula-show-left-sep 
          set -g @dracula-show-right-sep 
          set -g @dracula-border-contrast true
          set -g @dracula-cpu-usage true
          set -g @dracula-ram-usage true
          set -g @dracula-gpu-usage false
          set -g @dracula-day-month false
          set -g @dracula-show-time true
          set -g @dracula-refresh-rate 5
        '';
      }
    ];
  };
}