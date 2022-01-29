/* vim: set filetype=nix ts=2 sw=2 tw=0 et :*/
{ pkgs, ...}:

{
programs.tmux = {
    enable = true;
    terminal = "\${TERM}";
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 10;
    keyMode = "vi";
    historyLimit = 10000;
    extraConfig = ''
      # Force Tmux to use 24bit colour
      set-option -sa terminal-overrides ",alacritty*:Tc"

      # Let nvim use 'undercurls' correctly:
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      # underscore colours - needs tmux-3.0
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

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
      bind r source-file ~/.config/tmux/tmux.conf

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
        extraConfig= ''
        # available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, network, network-bandwidth, weather, time
        set -g @dracula-plugins "battery cpu-usage ram-usage time"

        set -g @dracula-show-powerline true
        set -g @dracula-show-flags true
        set -g @dracula-show-left-icon session

        set -g @dracula-day-month true
        set -g @dracula-show-timezone false
        set -g @dracula-military-time true
        '';
      }
    ];
  };
}
