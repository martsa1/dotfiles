{
  config,
  pkgs,
  ...
}: let
  cache_dir = "/home/metube/metube_cache";
in {
  users.extraUsers.metube = {
    createHome = true;
    description = "metube";
    isNormalUser = true;
    group = "podman";
    uid = 1012;
    linger = true;
  };
  users.groups = {
    podman = {};
  };

  # Setup data directories declaratively, (see inspiration here:
  # https://discourse.nixos.org/t/creating-directories-and-files-declararively/9349
  # https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
  systemd.tmpfiles.rules = [
    "d ${cache_dir} 0755 metube podman"
  ];

  home-manager.users.metube = {
    home.stateVersion = "25.05";

    services.podman = {
      enable = true;
      containers.metube = {
        autoStart = true;
        description = "Metube";
        image = "ghcr.io/alexta69/metube";

        environment = {
          UID = "${builtins.toString config.users.users.metube.uid}";
          # GID = "${builtins.toString config.users.groups.podman.gid}";
          # TODO: Fix this config lookup...
          GID = 996; # Manually looked up!
        };

        # DLNA requires host-networking, consider using that instead?
        ports = [
          # "127.0.0.1:8096:8096"
          "8097:8081"
        ];

        volumes = [
          "/media/Multimedia/youtube_cache:/downloads"
          "/etc/localtime:/etc/localtime:ro"
          "${cache_dir}:/app/.cache"
        ];
        extraPodmanArgs = [
          "--userns=keep-id"
        ];
        labels = {
          "traefik.http.routers.metube.rule" = "Host(`metube.home`)";
          "traefik.http.routers.metube.tls" = "true";
          "traefik.http.routers.metube.tls.certresolver" = "internal";
          "traefik.http.services.metube.loadbalancer.server.port" = "3000";
        };
      };
    };
  };
}
