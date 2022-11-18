/* vim: set filetype=nix ts=2 sw=2 tw=0 et :*/
{ pkgs, lib, ... }:

let
  dracula_head = pkgs.tmuxPlugins.mkTmuxPlugin rec {
    pluginName = "dracula";
    version = "5b282b043f760bd27b6d8c32b10d111f618b4c21";
    src = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "tmux";
      rev = "${version}";
      sha256 = "sha256-Dhpj2NaIZO+IPsChr1uqKIR6Zv8F2QReEdU/RIVZHAc=";
    };
    meta = with lib; {
      homepage = "https://draculatheme.com/tmux";
      description = "A feature packed Dracula theme for tmux!";
      license = licenses.mit;
      platforms = platforms.unix;
      maintainers = with maintainers; [ ethancedwards8 ];
    };
  };

  in
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

      # Allow contents of pane to be preserved when interactive tool is used.
      set-option alternate-screen on

      # Let nvim use 'undercurls' correctly:
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      # underscore colours - needs tmux-3.0
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      # Make Tmux highlight activity in other panes by defualt
      setw -g monitor-activity on

      # move between splits
      # check prefix ? for binds and this overlaped with below
      # caused j to only jump once when using multiple times
      unbind -T prefix J
      # Now i can keep jumping with only one prefix use on down (j)
      bind -r -T prefix h select-pane -L
      bind -r -T prefix l select-pane -R
      bind -r -T prefix k select-pane -U
      bind -r -T prefix j select-pane -D

      # resize splits
      bind -r -T prefix M-h resize-pane -L 5
      bind -r -T prefix M-l resize-pane -R 5
      bind -r -T prefix M-k resize-pane -U 5
      bind -r -T prefix M-j resize-pane -D 5

      # Allow swapping panes around
      bind-key -r "<" swap-window -d -t -1
      bind-key -r ">" swap-window -d -t +1

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
        plugin = dracula_head;
        extraConfig = ''
          # Options available here:
          # https://github.com/dracula/tmux
          set -g @dracula-plugins "battery cpu-usage ram-usage time"

          set -g @dracula-cpu-display-load true

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
