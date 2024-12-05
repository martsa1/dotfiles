{...}: {
  virtualisation.oci-containers.containers.baby-buddy = {
    image = "lscr.io/linuxserver/babybuddy";
    autoStart = true;
    environment = {
      TZ = "Europe/London";
      CSRF_TRUSTED_ORIGINS = "http://127.0.0.1:8000,https://baby.abitmoredepth.com";
    };
    volumes = [
      "/var/baby-buddy:/config"
    ];
    extraOptions = [
      "--label=traefik.http.routers.baby-buddy.rule=Host(`baby.home`) || Host(`baby.abitmoredepth.com`)"
      "--label=traefik.http.routers.baby-buddy.tls=true"
      "--label=traefik.http.routers.baby-buddy.tls.certresolver=internal"
      "--label=traefik.http.services.baby-buddy.loadbalancer.server.port=8000"
    ];
  };
}
