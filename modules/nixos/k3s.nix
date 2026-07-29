# Opinionated wrapper over NixOS services.k3s.
#
# First entry in the flake's nixosModules output and the convention template
# for future modules: options namespaced under `sm.<name>`, inert unless
# `enable` is set, drives the upstream module rather than reinventing it.
{config, lib, pkgs, ...}: let
  cfg = config.sm.k3s;
in {
  options.sm.k3s = {
    enable = lib.mkEnableOption "k3s with home-lan defaults";

    role = lib.mkOption {
      type = lib.types.enum ["server" "agent"];
      default = "server";
      description = ''
        k3s role. A server runs the control plane (and workloads by default);
        an agent joins an existing server and requires `serverAddr`.
      '';
    };

    serverAddr = lib.mkOption {
      type = lib.types.str;
      default = "https://k1.home:6443";
      description = "API server URL that agents connect to (domain-based by default).";
    };

    tokenFile = lib.mkOption {
      # Deliberately a string, not a path literal: NixOS `types.path` accepts any
      # leading-'/' string, so this forwards to services.k3s.tokenFile while (a)
      # keeping any value out of the nix store and (b) not requiring the file to
      # exist at eval time. On real hosts this is set to the sops-decrypted path
      # (config.sops.secrets.k3s_token.path).
      type = lib.types.str;
      default = "/etc/k3s-token";
      description = "File holding the shared cluster join token (point this at a sops path on real hosts).";
    };

    extraFlags = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["--disable=traefik"];
      description = ''
        Extra k3s CLI flags. Traefik is disabled by default because we run our
        own ingress (Phase 2) and the bundled chart would also fight
        laptop-server's existing :80/:443 Traefik.
      '';
    };

    tlsSan = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = ''
        Extra subjectAltNames added to the k3s API serving certificate. List any
        hostname/IP clients will use to reach the API (e.g. "k1.home") so remote
        kubectl doesn't hit an x509 hostname mismatch. Only meaningful for servers.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = cfg.role;
      tokenFile = cfg.tokenFile;
      extraFlags = cfg.extraFlags ++ map (s: "--tls-san=${s}") cfg.tlsSan;
    } // lib.optionalAttrs (cfg.role == "agent") {
      # Only agents join an existing server. A standalone server must leave
      # serverAddr empty, otherwise k3s starts with `--server <addr>` and tries
      # to bootstrap by joining itself — fatal "connection refused" on first boot.
      serverAddr = cfg.serverAddr;
    };

    # k3s ships its own containerd, so this coexists with podman on laptop-server.
    environment.systemPackages = [
      pkgs.kubectl
      pkgs.k9s
    ];

    networking.firewall = {
      # 10250 kubelet (both roles); 6443 API (server only); 8472/udp flannel VXLAN.
      allowedTCPPorts = [10250] ++ lib.optional (cfg.role == "server") 6443;
      allowedUDPPorts = [8472];
    };
  };
}
