# NFS client support for k8s NFS-CSI volumes.
#
# The csi-driver-nfs node plugin mounts through the host kernel, so every node
# needs nfs-utils (mount.nfs & co.) present. k1 already gets it transitively
# via its /media NFS automounts; this module makes it explicit and uniform.
{config, lib, pkgs, ...}: let
  cfg = config.sm.nfs;
in {
  options.sm.nfs = {
    enable = lib.mkEnableOption "NFS client (nfs-utils) for k8s NFS-CSI volumes";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.nfs-utils];
  };
}
