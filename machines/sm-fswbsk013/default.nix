{ config, pkgs, ... }:

let
  glPkgs = import (<nixgl>) {};
  #unstable_pkgs = import (
  #  fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
  #) {};
in
{
  imports = [
    ../linux_base
  ];

  home.packages = with pkgs; [
    remmina
    #evolutionWithPlugins
    #evolution

    #glPkgs.auto.nixGLDefault
    glPkgs.nixGLIntel
    #alacritty

    postman

    python3Packages.poetry

    vagrant
  ];

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
    options = [ "ctrl:nocaps" ];
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
}
