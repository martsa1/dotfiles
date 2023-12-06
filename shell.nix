{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    alejandra
    # keep this line if you use bash
    # pkgs.bashInteractive
  ];
}
