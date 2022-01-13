{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib, stdenv ? pkgs.stdenv, fetchzip ? pkgs.fetchzip, gtk-engine-murrine ? pkgs.gtk-engine-murrine }:

# Largely plagiarised from the NixPkgs Dracula GTK Theme:
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/themes/dracula-theme/default.nix
let
  themeName = "Dracula";
  version = "3.0";
in
stdenv.mkDerivation {
  pname = "dracula-icons";
  inherit version;

  src = fetchzip {
    url = "https://github.com/dracula/gtk/files/5214870/Dracula.zip";
    sha256 = "1kcnymh36yjbl2z06kqzc1p6lj98lfw7jpc3w1hifvrp0ab8mi5d";
  };

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  installPhase = ''
    mkdir -p $out/${themeName}
    cp -ra . $out/${themeName}
  '';

  meta = with lib; {
    description = "Dracula Icons";
    homepage = "https://github.com/dracula/gtk";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ alexarice ];
  };
}
