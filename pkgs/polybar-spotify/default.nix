{
  pkgs ? import <nixpkgs> {},
  python3 ? pkgs.python38
}:

let
  commit = "055c8ab01eda6ade05c3d277d52e1dcb71d0b1ff";
  hash = "1q12h117lwzaambpbr029ld8fip6i7sy690pfv4n6d1n8h5plqhh";

  # polybar-spotify depends on dbus-python, itself requiring the dbus libraries.
  python_deps = python3.withPackages (ps: [ ps.dbus-python ]);
in
  pkgs.stdenv.mkDerivation {
    pname = "polybar-spotify-src";
    version = commit;

    src = pkgs.fetchFromGitHub {
      owner = "Jvanrhijn";
      repo = "polybar-spotify";
      rev = commit;
      sha256 = hash;
    };

    propagatedBuildInputs = [
      pkgs.dbus
      python_deps
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp $src/spotify_status.py $out/bin/polybar-spotify
    '';
  }
