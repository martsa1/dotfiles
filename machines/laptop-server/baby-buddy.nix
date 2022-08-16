{ ... }:
{
  virtualisation.oci-containers.containers.baby-buddy = {
    image = "lscr.io/linuxserver/babybuddy";
    autoStart = true;
    environment = {
      TZ = "Europe/London";
      CSRF_TRUSTED_ORIGINS = "http://127.0.0.1:8000,https://baby.abitmoredepth.com";
    };
    ports = [
      "80:8000"
    ];
    volumes = [
      "/var/baby-buddy:/config"
    ];
  };
}
