{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    alejandra
    python3Packages.python-lsp-server
    python3Packages.ruff
    # keep this line if you use bash
    # pkgs.bashInteractive
  ];
}
