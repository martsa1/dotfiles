# vim: set filetype=nix ts=2 sw=2 tw=0 et :
{ config, pkgs, ...}:

let
  # unstable_pkgs = import <nixpkgs-unstable> {};
  unstable_pkgs = import (
    fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
  ) {};

  python_version = pkgs.python39;
  custom_pkgs = pkgs.callPackage ../../pkgs/all.nix {
    inherit config;
    inherit pkgs;
    python3=python_version;
  };
in

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  imports = [
    # Enable and manage tmux via home-manager
    ../../dotfiles/tmux
  ];

  # Various packages I want my user to have access to
  home.packages = with pkgs; [
    bat
    custom_pkgs.rofi-dracula-theme
    docker-compose
    file
    jq
    lsd
    meld
    pass
    pstree
    python39Packages.ipython
    python39Packages.powerline
    rnix-lsp
    tldr
    universal-ctags
    zplug
    # unstable_pkgs.zplug
    vifm

    # Youtube stuff
    youtube-dl
    ffmpeg
  ];

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh.enable = false;

      # Ensure ZSH setup pulls in my dotfiles stuff...
      initExtra = ''
        export powerline_config_path="${pkgs.python39Packages.powerline.outPath}/share/zsh/powerline.zsh"

        if [ -f "$HOME/.config/nixpkgs/dotfiles/zsh/zshrc" ]; then
          source "$HOME/.config/nixpkgs/dotfiles/zsh/zshrc"
        fi
      '';
    };

    alacritty = {
      enable = true;
    };

    neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      extraPackages = [ pkgs.gcc ];
      viAlias = false;
      extraConfig = builtins.readFile ../../nvim/init.vim;
    };

    git = {
      enable = true;

      userName = "Sam Martin-Brown";
      userEmail = "Nivekkas@gmail.com";

      delta.enable = true;
      delta.options = {
        line-numbers = true;
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
      };

    };
  };

  # Enable FZF
  programs.fzf.enable = true;

  # config file management
  xdg.enable = true;
  xdg.configFile = {
    "alacritty/alacritty.yml".source = ../../dotfiles/alacritty/alacritty.yml;

    "nvim/init.vim".source = ../../nvim/config/standalone.vim;
    "nvim/after".source = ../../nvim/after;
    "nvim/after".recursive = true;

    "powerline".source = ../../dotfiles/powerline;
  };
}


