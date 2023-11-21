{pkgs ? import <nixpkgs> {}}: let
  commit = "6e69ba449f25eb9cd6adbe1466d0ef602dbb1a07";
  hash = "0r9xv53likapq4k8n46lcisayr670pv35lr34ja0l9z0f8gl8sv2";
in
  pkgs.stdenv.mkDerivation {
    pname = "rofi-dracula-src";
    version = commit;

    src = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "rofi";
      rev = commit;
      sha256 = hash;
    };

    buildPhase = ''
      cp $src/theme/config1.rasi config1.rasi
      chmod 0770 config1.rasi

      echo "element-text, element-icon {" | tee -a config1.rasi
      echo "    background-color: inherit;" | tee -a config1.rasi
      echo "    text-color:       inherit;" | tee -a config1.rasi
      echo "}" | tee -a config1.rasi
    '';

    installPhase = ''
      mkdir -p $out/
      cp $src/theme/*.rasi $out/
      cp -f config1.rasi $out/config1.rasi
    '';
  }
