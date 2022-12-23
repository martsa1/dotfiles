{ ... }:
{
  virtualisation.oci-containers.containers.home-assistant = {
    #services:
    #  homeassistant:
    #    container_name: homeassistant
    #    image: "ghcr.io/home-assistant/home-assistant:stable"
    #    volumes:
    #      - /PATH_TO_YOUR_CONFIG:/config
    #      - /etc/localtime:/etc/localtime:ro
    #    restart: unless-stopped
    #    privileged: true
    #    network_mode: host

    #image = "ghcr.io/home-assistant/home-assistant:stable";
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
    ];
  };
}
