{ ... }:

let
  traefik_config = ./traefik.yaml;
in
{
  virtualisation.oci-containers.containers.traefik = {
    image = "docker.io/traefik";
    autoStart = true;
    environment = {
      LEGO_CA_CERTIFICATES = "/var/rootCA.crt";
    };
    ports = [
      "80:80"
      "443:443"
      "8080:8080" # Dashboard
      "8000:8000"
    ];
    volumes = [
      "/var/run/podman/podman.sock:/var/run/docker.sock:ro"
      "${traefik_config}:/etc/traefik/traefik.yaml"
      "/var/step-ca/rootCA.crt:/var/rootCA.crt"
    ];

    extraOptions = [
      "--label=traefik.http.routers.traefik.rule=Host(`traefik.laptop-server.home`, `laptop-server.home`)"
      "--label=traefik.http.routers.traefik.tls=true"
      "--label=traefik.http.routers.traefik.tls.certresolver=internal"
      "--label=traefik.http.services.traefik.loadbalancer.server.port=8080"
      "--label=traefik.http.middlewares.tohttps.redirectscheme.scheme=https"
      "--label=traefik.http.middlewares.tohttps.redirectscheme.permanent=true"
    ];
  };
}

