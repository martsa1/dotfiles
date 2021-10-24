{
  pkgs ? import <nixpkgs> {},
  python3 ? pkgs.python38,
  username ? "sam"
}:

let
  # We need these during the config jinja rendering stage
  build_deps = python3.withPackages (ps: [ ps.jinja2 ]);
in
  pkgs.stdenv.mkDerivation {
      pname = "sm-i3-configuration";
      version = "1.0.0";

      src = ../../dotfiles/i3;

      # Disable all other steps.
      phases = "installPhase";

      buildInputs = [build_deps];

      USERNAME = username;

      installPhase = ''
        mkdir -p $out
	      python3 $src/render_config.py > $out/config
      '';
  }
