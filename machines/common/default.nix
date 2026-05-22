# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{
  config,
  inputs,
  pkgs,
  outputs,
  ...
}:

let
  nvimPythonEnv = pkgs.python3.withPackages (ps: with ps; [
    mypy
    pylsp-mypy
    python-lsp-server
  ]);
in
{
  imports = [
    # Enable and manage tmux via home-manager
    ../../dotfiles/tmux
  ];

  nixpkgs.overlays = outputs.overlays ;

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    rofi-dracula-theme
    curl
    # direnv
    docker-compose
    fd
    feh
    file
    font-awesome_5
    fira
    imagemagick
    jq
    libnotify
    lsd
    luaformatter
    meld
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.noto
    nil
    nixd
    openmoji-color
    pass
    pstree
    python3
    python3Packages.ipython
    ripgrep
    roboto
    roboto-mono
    source-code-pro
    tldr
    universal-ctags
    vifm
    zplug
  ];

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh.enable = false;
      zplug.enable = true;

      # Try to avoid relying on random system-wide settings...
      initExtraFirst = ''
        zmodload zsh/zle 2>/dev/null || true
        setopt NO_GLOBAL_RCS
        setopt ZLE
      '';

      # Ensure ZSH setup pulls in my dotfiles stuff...
      initExtra = ''
        export NIX_PATH=nixpkgs=${pkgs.path}:$NIX_PATH
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
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      extraPackages = with pkgs; [
        bash-language-server
        biome
        clang-tools
        claude-agent-acp
        cmake-language-server
        gcc
        nixd
        nvimPythonEnv
        ruff
        rust-analyzer
        tailwindcss-language-server
        ty
        typescript-language-server
        vscode-langservers-extracted
        vtsls
        vue-language-server
        yaml-language-server
        # lua-fmt
        # zuban
        # zls
      ];
      viAlias = false;
      withRuby = false;
      withPython3 = false;
      withNodeJs = false;
      sideloadInitLua = true; # Prevent writing init.lua so I can manage it myself
      #extraConfig = builtins.readFile ../../nvim/init.vim;
      #initLua = builtins.readFile ../../nvim/init.lua;
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
        syntax-theme = "Dracula";
        tabs = 4;
      };
    };

    git = {
      enable = true;

      settings = {
        user.name = "Sam Martin-Brown";
        user.email = "Nivekkas@gmail.com";


        signing.signByDefault = true;
        commit.gpgSign = true;
        signing.format = "openpgp";
        # Setting this option might override default signing key selection...?
        #signing.key = "61CB737879759A958B6B886626E45D5144EF59EA";
        # signing.key = null;

        alias = {
          d = "diff";
        };

        # ignores = [
        #   "tags"
        # ];

        init = {
          defaultBranch = "main";
        };

        merge = {
          tool = "${pkgs.meld}/bin/meld";
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
    "nixpkgs/config.nix".source = ../../config.nix;
    "alacritty/alacritty.toml".source = ../../dotfiles/alacritty/alacritty.toml;
    "starship.toml".source = ../../dotfiles/starship/starship.toml;
  };

  # Direct symlink to repo nvim dir so edits apply without rebuild (no store copy).
  home.activation.linkNvimConfig = config.lib.dag.entryAfter ["writeBoundary"] ''
    ln -sfn "${config.home.homeDirectory}/.config/home-manager/nvim" "${config.home.homeDirectory}/.config/nvim"
  '';

  # Symlink nix-compiled treesitter parsers into nvim's data dir so they're on
  # runtimepath without home-manager owning ~/.config/nvim (which would break
  # the mkOutOfStoreSymlink live-edit setup).
  xdg.dataFile."nvim/site/parser".source =
    "${pkgs.vimPlugins.nvim-treesitter.withPlugins (p: builtins.attrValues p)}/parser";

  home.file = {
    # Direnv rc for extra layouts
    ".direnvrc".source = ../../dotfiles/direnvrc;
  };

  home.language = {
    base = "en-gb";
  };

  # Enable direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # Enable bat and theme it with dracula
  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };
}

