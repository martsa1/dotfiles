{config, ...}: let
  gitea_base_dir = "/var/gitea";
  gitea_config_dir = builtins.concatStringsSep "/" [gitea_base_dir "config"];
  gitea_data_dir = builtins.concatStringsSep "/" [gitea_base_dir "data"];
in {
  # Define a user to run this container with.
  users.users.gitea = {
    createHome = false;
    description = "Gitea";
    isNormalUser = true;
    group = "podman";
    uid = 1010;
  };
  users.groups = {
    podman = {
      gid = 10001;
    };
  };

  # POssible way to have this whole container run by a specific user (from host's perspective)
   #systemd.services.podman-hass.serviceConfig.User = "podmanager";

  # Setup the data directory declaratively, (see inspiration here:
  # https://discourse.nixos.org/t/creating-directories-and-files-declararively/9349
  # https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
  systemd.tmpfiles.rules = [
    "d ${gitea_data_dir} 0755 gitea podman"
    "d ${gitea_config_dir} 0755 gitea podman"
  ];
  # Setup the container
  virtualisation.oci-containers.containers.gitea = {
    image = "gitea/gitea:latest-rootless";
    autoStart = true;
    user = "${builtins.toString config.users.users.gitea.uid}:${builtins.toString config.users.groups.podman.gid}";
    volumes = [
      "${gitea_data_dir}:/var/lib/gitea"
      "${gitea_config_dir}:/etc/gitea"
      #"/etc/timezone:/etc/timezone:ro"
      "/etc/localtime:/etc/localtime:ro"
    ];
    labels = {
      #"traefik.http.routers.gitea.rule" = "Host(`git.home`, `git.abitmoredepth.com`)";
      "traefik.http.routers.gitea.rule" = "Host(`git.home`)";
      "traefik.http.routers.gitea.tls" = "true";
      "traefik.http.routers.gitea.tls.certresolver" = "internal";
      "traefik.http.services.gitea.loadbalancer.server.port" = "3000";
    };
  };
}
