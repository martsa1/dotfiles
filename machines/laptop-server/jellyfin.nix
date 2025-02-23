{
  config,
  pkgs,
  ...
}:
let
  config_dir = "/home/jellyfin/config";
  cache_dir = "/home/jellyfin/cache";
in {
  users.extraUsers.jellyfin = {
    createHome = true;
    description = "Jellyfin";
    isNormalUser = true;
    group = "podman";
    uid = 1011;
    linger = true;
  };
  users.groups = {
    podman = {};
  };

  # # Setup data directories declaratively, (see inspiration here:
  # # https://discourse.nixos.org/t/creating-directories-and-files-declararively/9349
  # # https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
  systemd.tmpfiles.rules = [
    "d ${config_dir} 0755 jellyfin podman"
    "d ${cache_dir} 0755 jellyfin podman"
  ];

  home-manager.users.jellyfin = {
    home.stateVersion = "25.05";

    services.podman = {
      enable = true;
      containers.jellyfin = {
        autoStart = true;
        description = "Jellyfin server";
        image = "jellyfin/jellyfin";

        # DLNA requires host-networking, consider using that instead?
        ports = [
          # "127.0.0.1:8096:8096"
          "8096:8096"
        ];
        devices = [
          # VAAPI Devices
          "/dev/dri/renderD128:/dev/dri/renderD128"
          "/dev/dri/card0:/dev/dri/card0"
        ];

        volumes = [
          "${config_dir}:/config"
          "${cache_dir}:/cache"
          "/media/Multimedia:/media"
          "/etc/localtime:/etc/localtime:ro"
        ];
        labels = {
          "traefik.http.routers.jellyfin.rule" = "Host(`jellyfin.home`)";
          "traefik.http.routers.jellyfin.tls" = "true";
          "traefik.http.routers.jellyfin.tls.certresolver" = "internal";
          "traefik.http.services.jellyfin.loadbalancer.server.port" = "3000";
        };
      };
    };
  };
}
