{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    poetry
    python311

    ## keep this line if you use bash
    #pkgs.bashInteractive
  ];
}
