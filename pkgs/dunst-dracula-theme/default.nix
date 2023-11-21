{pkgs ? import <nixpkgs> {}}: let
  commit = "0518e14618a659b22f20a4e2f0462a853477637e";
  hash = "09qpj38ka231y1xi0yawzv4ws396iy5icdjng9848kpz34x6b9ay";
in
  pkgs.stdenv.mkDerivation {
    pname = "dunst-dracula-theme";
    version = commit;

    src = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "dunst";
      rev = commit;
      sha256 = hash;
    };

    installPhase = ''
      mkdir -p $out
      cp $src/dunstrc $out/dunstrc

      sed -i 's|transparency\s*=\s*[0-9]*|transparency = 5|' $out/dunstrc
    '';
  }
