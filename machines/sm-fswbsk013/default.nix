{
  config,
  pkgs,
  ...
}: let
  glPkgs = import <nixgl> {};
  #unstable_pkgs = import (
  #  fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
  #) {};
in {
  imports = [
    ../linux_base
  ];

  home.packages = with pkgs; [
    clang-tools # C++ stuff for work...

    remmina
    #evolutionWithPlugins  # Can't use this outside of actual nixos it seems...
    duplicity
    deja-dup

    #glPkgs.auto.nixGLDefault
    glPkgs.nixGLIntel
    #alacritty

    podman
    postman

    poetry

    vagrant

    kdiff3
    #yubioath-flutter

    #spotify-tui

    #nodejs # no getting away from node...
    nodejs_latest # no getting away from node...
  ];

  # Set a state version (determines various stateful bits and pieces. Should
  # try to update from time to time (Stuff may break)
  home.stateVersion = "22.05";

  # Username/homedir to reference in various bits of home manager - no default
  # provided as of stateVersion > 20.09.
  home.username = "sam";
  home.homeDirectory = "/home/sam";

  # Attempt to ensure home-manager uses latest available nix version
  nix.package = pkgs.nix;

  home.shellAliases = {
    docker = "podman";
  };

  # Seemingly needed for work machine to find all ZSH aliases, see here for more:
  # https://github.com/nix-community/home-manager/issues/2562#issuecomment-1009381061
  programs.zsh.initExtraBeforeCompInit = ''
    fpath+=("${config.home.profileDirectory}"/share/zsh/site-functions "${config.home.profileDirectory}"/share/zsh/$ZSH_VERSION/functions "${config.home.profileDirectory}"/share/zsh/vendor-completions)
  '';

  # Do magic when not on NixOS
  targets.genericLinux.enable = true;

  # Set keyboard layout to gb, disable pesky capslock.
  home.keyboard = {
    layout = "us";
    options = ["ctrl:nocaps"];
    # To manually swap back to UK layout:
    # setxkbmap gb -option ctrl:nocaps (or run keyboard-gb)
  };

  # Rest of neovim settings are in common.
  #programs.neovim = {
  #plugins = with pkgs.vimPlugins; [
  #  (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
  #];
  #};
  # Try symlinking some package path over the top of old-style tree-sitter setup..?
  xdg.configFile = {
    #"nvim/init.vim".source = ../../nvim/config/standalone.vim;
    #"nvim/after".source = ../../nvim/after;
    #"nvim/after".recursive = true;

    # If treesitter stuff needs rebuilding, it can be done safely inside a nix-shell:
    # nix-shell -p neovim gcc coreutils git cacert --pure

    #"nvim/plugged/nvim-treesitter/parser/python.so".source = #"${pkgs.tree-sitter-grammars.tree-sitter-python.outPath}/parser";
    #"nvim/plugged/nvim-treesitter/parser/lua.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-lua.outPath}/parser";
    #"nvim/plugged/nvim-treesitter/parser/cpp.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-cpp.outPath}/parser";
    #"nvim/plugged/nvim-treesitter/parser/c.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-c.outPath}/parser";
    #"nvim/plugged/nvim-treesitter/parser/json.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-json.outPath}/parser";
    #"nvim/plugged/nvim-treesitter/parser/yaml.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-yaml.outPath}/parser";
  };

  # Enable syncthing
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  # Doesn't seem to work when not on nixos...
  ## setup picom compositor
  #services.picom = {
  #  enable = true;
  #  #backend = "glx";
  #  fade = true;
  #  fadeDelta = 10;
  #  activeOpacity = 1;
  #  inactiveOpacity = 0.95;
  #};

  #services.spotifyd = {
  #  enable = true;
  #  settings = {
  #    global = {
  #      username = "11162549442";
  #      password_cmd = "pass personal/spotify.com | grep password | cut -d ' ' -f 2";
  #      device_type = "computer";
  #      backend = "pulseaudio";
  #    };
  #  };
  #};
}
