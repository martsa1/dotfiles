# Attempt to pull in the aws CLI 2 overlay provided here: https://github.com/hackworthltd/hacknix/blob/master/pkgs/awscli/2.0/default.nix
# See issue here: https://github.com/NixOS/nixpkgs/issues/80956
# Some more info here about how to do this: https://nixos.wiki/wiki/Import_From_Derivation
{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
}: let
  aws_derivation = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/hackworthltd/hacknix/af4ca0690767df1a26493275cd13d4fb26e03eae/pkgs/awscli/2.0/default.nix";
    sha256 = "0gdrr4102g588z3sjaidwqga2kbw6rxqypc8aj25gap9692hln8c";
  };

  awscli = import aws_derivation;
in
  awscli {
    fetchurl = pkgs.fetchurl;
    groff = pkgs.groff;
    less = pkgs.less;
    inherit lib;
    python3 = pkgs.python38;
  }
