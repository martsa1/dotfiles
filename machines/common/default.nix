# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{
  config,
  pkgs,
  ...
}: let
  nvim_nightly = import (
    builtins.fetchTarball https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz
  );

  moz_overlay = import (
    builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz
  );

  custom_pkgs = import ../../overlay.nix;
in {
  nixpkgs.overlays = [
    nvim_nightly
    # moz_overlay
    custom_pkgs
  ];

  imports = [
    # Enable and manage tmux via home-manager
    ../../dotfiles/tmux
  ];

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    rofi-dracula-theme
    curl
    direnv
    docker-compose
    fd
    feh
    file
    font-awesome
    imagemagick
    jq
    libnotify
    lsd
    luaformatter
    meld
    (nerdfonts.override {fonts = ["FiraCode" "FiraMono" "Noto"];})
    nodePackages.lua-fmt  # TODO: Only nvim should really need this...
    nodePackages.bash-language-server  # TODO: Only nvim should really need this...
    pass
    pstree
    python3
    python3Packages.ipython
    python3Packages.powerline
    ripgrep
    rnix-lsp
    roboto
    roboto-mono
    source-code-pro
    tldr
    universal-ctags
    vifm
    yaml-language-server
    zplug
  ];

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh.enable = false;
      zplug.enable = true;

      # Try to avoid relying on random system-wide settings...
      initExtraFirst = ''
        setopt NO_GLOBAL_RCS
        setopt ZLE
      '';

      # Ensure ZSH setup pulls in my dotfiles stuff...
      initExtra = ''
        if [ -f "$HOME/.config/home-manager/dotfiles/zsh/zshrc" ]; then
          source "$HOME/.config/home-manager/dotfiles/zsh/zshrc"
        fi
      '';

      envExtra = ''
        if [[ -o login ]]; then
        else
          source "$HOME/.config/home-manager/dotfiles/zsh/envs.zsh"
        fi
      '';
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    alacritty = {
      enable = true;
    };

    neovim = {
      enable = true;
      extraPackages = [pkgs.gcc];
      viAlias = false;
      #extraConfig = builtins.readFile ../../nvim/init.vim;
      extraLuaConfig = builtins.readFile ../../nvim/init.lua;
    };

    git = {
      enable = true;

      userName = "Sam Martin-Brown";
      userEmail = "Nivekkas@gmail.com";

      delta.enable = true;
      delta.options = {
        line-numbers = true;
        syntax-theme = "Dracula";
      };

      signing.signByDefault = true;
      signing.key = "61CB737879759A958B6B886626E45D5144EF59EA";

      aliases = {
        d = "diff";
      };

      ignores = [
        "tags"
      ];

      extraConfig = {
        init = {
          defaultBranch = "main";
        };

        "mergetool \"nvim\"" = {
          cmd = "nvim -f \"$BASE\"\"$LOCAL\"\"$REMOTE\"\"$MERGED\" ";
        };
      };
    };

    # Enable FZF
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # Let home-manager manage itself.
    home-manager.enable = true;
  };

  # config file management
  xdg.enable = true;
  xdg.configFile = {
    "nix/nix.conf".source = ../../nix.conf;
    "alacritty/alacritty.yml".source = ../../dotfiles/alacritty/alacritty.yml;

    #"nvim/init.vim".source = ../../nvim/config/standalone.vim;
    "nvim/after".source = ../../nvim/after;
    "nvim/after".recursive = true;
    "nvim/lua".source = ../../nvim/lua;
    "nvim/lua".recursive = true;
    "nvim/snippets".source = ../../nvim/snippets;
    "nvim/snippets".recursive = true;

    #"powerline".source = ../../dotfiles/powerline;
    "starship.toml".source = ../../dotfiles/starship/starship.toml;
  };

  home.file = {
    # Direnv rc for extra layouts
    ".direnvrc".source = ../../dotfiles/direnvrc;
  };

  # Enable direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  # Enable bat and theme it with dracula
  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };
}
