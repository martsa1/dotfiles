{
  pkgs ? import <nixpkgs> {},
  python3 ? pkgs.python3,
}:
pkgs.stdenv.mkDerivation {
  pname = "polybar-mute";
  version = "1.0.0";

  src = ../../dotfiles/i3/scripts;

  propagatedBuildInputs = [
    python3
    pkgs.pulseaudio
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/input_mute.py $out/bin/polybar-mute
  '';
}
