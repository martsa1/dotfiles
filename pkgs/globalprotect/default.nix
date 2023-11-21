{pkgs ? import <nixpkgs> {}}:
# Some advice here: https://nixos.wiki/wiki/Packaging/Binaries
# See also the packaging manual: https://nixos.org/manual/nixpkgs/stable/
let
  version = "6.0.1";
  src = builtins.fetchurl {
    url = "https://artifactory.f-secure.com/artifactory/global-protect-linux-generic-local/PanGPLinux-6.0.1-c6.tgz";
    sha256 = "06bhxbc96yldvxbwblrrbkpl52vcyzivk0lhbz7j98r0s86ks78w";
  };
  deb_name = "GlobalProtect_UI_deb-${version}.1-6.deb";
in
  pkgs.stdenv.mkDerivation {
    pname = "PaloAlto GlobalProtect";
    inherit version;

    system = "x86_64-linux";

    inherit src;
    inherit deb_name;

    buildInputs = [
      pkgs.qt5.qtbase
      pkgs.qt5.qtwebkit
    ];

    nativeBuildInputs = [
      pkgs.autoPatchelfHook # Automatically setup the loader, and do the magic
      pkgs.dpkg
      pkgs.qt5.wrapQtAppsHook
    ];

    #dontUnpack = true;
    unpackPhase = ''
      mkdir pkg
      mkdir outer

      echo "Extracting outer tarball."
      pushd outer
      tar xvf $src
      popd

      echo "Unpacking deb archive."
      dpkg -x outer/$deb_name pkg

      sourceRoot=pkg
    '';

    dontPatch = true; # We have no patches to apply, skip this default.
    dontConfigure = true; # We aren't compiling either.
    dontBuild = true;

    # Should run from the directory set in 'sourceRoot' above.
    installPhase = ''
      mkdir -p $out/{bin,lib,service_templates,tmp}

      mv opt/paloaltonetworks/globalprotect/{gpshow.sh,gp_support.sh,pre_exec_gps.sh} $out/bin
      mv opt/paloaltonetworks/globalprotect/{globalprotect,PanGPA,PanGpHip,PanGpHipMp,PanGPS,PanGPUI} $out/bin

      mv opt/paloaltonetworks/globalprotect/license.cfg $out/

      find opt/paloaltonetworks/globalprotect -name "*.so*" -exec mv {} $out/lib \;

      find opt/paloaltonetworks/globalprotect -name "*.service" -exec mv {} $out/service_templates \;

      # Move over desktop files, icons etc.
      mv usr $out/usr
      find opt/paloaltonetworks/globalprotect -name "*.desktop" -exec mv {} $out/usr/share/applications \;

      rm -rf opt

      touch $out/pangps.xml
      echo "<Portal>193.110.108.180</Portal>" > $out/pangps.xml

      rm -rf usr
    '';
  }
