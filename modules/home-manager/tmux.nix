/*
vim: set filetype=nix ts=2 sw=2 tw=0 et :
*/
# Sams tmux config. Unlike the other home-manager modules this one defaults to
# *on*: every machine has wanted tmux so far, so new machines opt out with
# `sm.tmux.enable = false;` rather than opting in.
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.sm.tmux;

  claude-session-manager = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "claude-session-manager";
    version = inputs.tmux-claude-session-manager.shortRev;
    src = inputs.tmux-claude-session-manager;

    # The scripts call fzf/jq bare *and* preflight them with `command -v`, so
    # the store paths have to be on PATH rather than substituted at the call
    # sites. Every script sources helpers.sh first, so exporting there covers
    # all of them. `claude` itself stays on PATH from home.packages.
    postInstall = ''
      echo 'export PATH="${lib.makeBinPath [pkgs.fzf pkgs.jq]}:$PATH"' \
        >> $target/scripts/helpers.sh
    '';

    meta = with lib; {
      homepage = "https://github.com/craftzdog/tmux-claude-session-manager";
      description = "List, monitor and jump across nested Claude Code sessions";
      license = licenses.mit;
      platforms = platforms.unix;
    };
  };

  dracula_head = pkgs.tmuxPlugins.mkTmuxPlugin rec {
    pluginName = "dracula";
    version = "e8598158df58415e9413dddd34c9f818335443d0";
    src = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "tmux";
      rev = "${version}";
      sha256 = "sha256-b11lTY560GtDq3H0BtSvrbkjajCd8mqdeujVALcnsTg=";
    };
    meta = with lib; {
      homepage = "https://draculatheme.com/tmux";
      description = "A feature packed Dracula theme for tmux!";
      license = licenses.mit;
      platforms = platforms.unix;
      maintainers = with maintainers; [ethancedwards8];
    };
  };
in {
  options.sm.tmux = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Whether to enable Sams tmux config. On by default; set to false to opt a machine out.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      terminal = "\${TERM}";
      aggressiveResize = true;
      baseIndex = 1;
      clock24 = true;
      escapeTime = 10;
      keyMode = "vi";
      historyLimit = 50000;
      extraConfig = ''
        # Force Tmux to use 24bit colour
        set-option -sa terminal-overrides ",alacritty*:Tc"
        set -as terminal-features ",gnome*:RGB"

        # Claude Code inside tmux: allow-passthrough lets desktop notifications
        # and the progress bar reach the outer terminal; extended-keys lets tmux
        # tell Shift+Enter apart from Enter. terminal-features is matched against
        # the *outer* terminal's TERM, so xterm* alone would miss alacritty.
        # https://code.claude.com/docs/en/terminal-config#configure-tmux
        set -g allow-passthrough on
        set -s extended-keys on
        set -as terminal-features ",xterm*:extkeys"
        set -as terminal-features ",alacritty*:extkeys"
        set -as terminal-features ",kitty*:extkeys"

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

        # Open new panes/splits in current path by default
        bind-key "c" new-window -c "#{pane_current_path}"
        bind '"' split-window -v -c "#{pane_current_path}"
        bind '%' split-window -h -c "#{pane_current_path}"

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
          plugin = claude-session-manager;
          extraConfig = ''
            set -g @claude_launch_key 'a'
            set -g @claude_list_key 'A'
          '';
        }
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
  };
}
