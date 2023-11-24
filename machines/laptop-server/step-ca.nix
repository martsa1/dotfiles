{...}: {
  # Define a user to run this container as.
  users.users.step = {
    createHome = false;
    description = "Step-CA";
    isSystemUser = true;
    group = "step";
  };
  users.groups = {
    step = {};
  };

  # Define the container
  virtualisation.oci-containers.containers.step-ca = {
    image = "docker.io/smallstep/step-ca";
    user = "step";
    autoStart = true;
    ports = [
      "8443:8443"
    ];
    volumes = [
      "/var/step-ca/:/home/step"
    ];
    extraOptions = [
      "--hostuser=step"
    ];
  };
}
