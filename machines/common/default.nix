# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{
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
    nodePackages.lua-fmt # TODO: Only nvim should really need this...
    nodePackages.bash-language-server # TODO: Only nvim should really need this...
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
        clang-tools
        cmake-language-server
        gcc
        nixd
        nodePackages.bash-language-server
        nodePackages.lua-fmt
        nodePackages.typescript-language-server
        nvimPythonEnv
        ruff
        vscode-langservers-extracted
        yaml-language-server
        zls
        zuban
      ];
      viAlias = false;
      #extraConfig = builtins.readFile ../../nvim/init.vim;
      extraLuaConfig = builtins.readFile ../../nvim/init.lua;
    };

    git = {
      enable = true;

      settings = {
        user.name = "Sam Martin-Brown";
        user.email = "Nivekkas@gmail.com";

        delta.enable = true;
        delta.options = {
          line-numbers = true;
          syntax-theme = "Dracula";
          tabs = 4;
        };

        signing.signByDefault = true;
        # Setting this option might override default signing key selection...?
        #signing.key = "61CB737879759A958B6B886626E45D5144EF59EA";
        # signing.key = null;

        aliases = {
          d = "diff";
        };

        # ignores = [
        #   "tags"
        # ];

        extraConfig = {
          init = {
            defaultBranch = "main";
          };

          "mergetool \"nvim\"" = {
            cmd = "nvim -f \"$BASE\"\"$LOCAL\"\"$REMOTE\"\"$MERGED\" ";
          };
        };
      };
    };
    delta = {
      enableGitIntegration = true;
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
