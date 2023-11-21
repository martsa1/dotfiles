{
  pkgs ? import <nixpkgs> {},
  python3 ? pkgs.python38,
}:
pkgs.stdenv.mkDerivation {
  pname = "polybar-launcher";
  version = "1.0.0";

  src = ../../dotfiles/polybar;

  propagatedBuildInputs = [
    python3
    pkgs.xorg.xrandr
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/launch.py $out/bin/polybar-launcher
  '';
}
