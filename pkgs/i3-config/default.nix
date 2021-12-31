{
  pkgs ? import <nixpkgs> {},
  python3 ? pkgs.python38,
  hostName ? {nixos = import <nixpkgs/nixos> {};}.nixos.config.networking.hostName,
  ...
}:

let
  # We need these during the config jinja rendering stage
  py_deps = python3.withPackages (ps: [ ps.jinja2 ]);
  #hostname = config.environment.etc.hostname.text;
in
  pkgs.stdenv.mkDerivation {
      pname = "sm-i3-configuration";
      version = "1.0.0";

      src = ../../dotfiles/i3;

      # Disable all other steps.
      phases = "installPhase";

      buildInputs = [py_deps];

      installPhase = ''
        mkdir -p $out
        export HOSTNAME="${hostName}"
	      python3 $src/render_config.py > $out/config
      '';
  }
