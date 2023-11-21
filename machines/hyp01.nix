{pkgs, ...}: let
  #python_env = pkgs.python3.withPackages
in {
  imports = [
    ../machines/mac_base
  ];

  home.packages = with pkgs; [
    python3
    python3Packages.poetry
  ];

  # Try symlinking some package path over the top of old-style tree-sitter setup..?
  xdg.configFile = {
    #"nvim/init.vim".source = ../../nvim/config/standalone.vim;
    #"nvim/after".source = ../../nvim/after;
    #"nvim/after".recursive = true;

    # If treesitter stuff needs rebuilding, it can be done safely inside a nix-shell:
    # nix-shell -p neovim gcc coreutils git cacert --pure

    "nvim/plugged/nvim-treesitter/parser/bash.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-bash.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/cmake.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-cmake.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/cpp.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-cpp.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/cuda.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-cuda.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/gdscript.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-gdscript.outPath}/parser";
    #"nvim/plugged/nvim-treesitter/parser/hcl.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-hcl.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/html.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-html.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/norg.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-norg.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/ocaml.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-ocaml.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/ocaml_interface.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-ocaml-interface.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/perl.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-perl.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/php.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-php.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/pug.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-pug.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/python.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-python.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/ruby.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-ruby.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/tlaplus.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-tlaplus.outPath}/parser";
    #"nvim/plugged/nvim-treesitter/parser/vala.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-vala.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/vue.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-vue.outPath}/parser";
    "nvim/plugged/nvim-treesitter/parser/yaml.so".source = "${pkgs.tree-sitter-grammars.tree-sitter-yaml.outPath}/parser";
  };
}
