{
  config,
  pkgs,
  ...
}: {
  users.extraUsers.jellyfin = {
    createHome = true;
    description = "Jellyfin";
    isNormalUser = true;
    group = "podman";
    uid = 1011;
    linger = true;
  };
  users.groups = {
    podman = {
      # gid = 10001;
    };
  };

  home-manager.users.jellyfin = {
    services.podman = {
      enable = true;
      containers.jellyfin = {
        autoStart = true;
        description = "Jellyfin server";
        image = "jellyfin/jellyfin";
      };
    };
  };
}
