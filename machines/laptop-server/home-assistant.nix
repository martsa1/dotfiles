{ ... }:
{
  virtualisation.oci-containers.containers.home-assistant = {
    image = "ghcr.io/home-assistant/home-assistant:stable";
    autoStart = true;
    #environment = {
    #};
    #ports = [
    #  "81:8123"
    #];
    volumes = [
      "/var/home-assistant:/config"
      "/etc/localtime:/etc/localtime:ro"
    ];
    extraOptions = [
      "--network=host"
      "--device=/dev/ttyACM0"

      "--label=traefik.http.routers.home-assistant.rule=Host(`ha.home`, `ha.abitmoredepth.com`)"
      "--label=traefik.http.routers.home-assistant.tls=true"
      "--label=traefik.http.routers.home-assistant.tls.certresolver=internal"
      "--label=traefik.http.services.home-assistant.loadbalancer.server.port=8123"
    ];
  };
}
