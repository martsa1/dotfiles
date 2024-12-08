{
  config,
  pkgs,
  ...
}: let
  gitea_base_dir = "/var/gitea";
  gitea_config_dir = builtins.concatStringsSep "/" [gitea_base_dir "config"];
  gitea_data_dir = builtins.concatStringsSep "/" [gitea_base_dir "data"];
  podman_shim_path = "/usr/local/bin/gitea_shim";
  gitea_shell_path = "/usr/local/bin/gitea_shell";

  gitea_shell_script = ''
    #!${pkgs.runtimeShell}
    sudo ${podman_shim_path} exec \
      -i --env "SSH_ORIGINAL_COMMAND=''${SSH_ORIGINAL_COMMAND}" \
      gitea sh "$@"
  '';
  gitea_shell = pkgs.writeScriptBin "gitea_shell" gitea_shell_script;
in {
  # Define a user to run this container with.
  users.extraUsers.gitea = {
    createHome = true;
    description = "Git";
    isNormalUser = true;
    group = "podman";
    uid = 1010;
    ignoreShellProgramCheck = true;
    shell = gitea_shell_path;
    linger = false;
  };
  users.groups = {
    podman = {
      # gid = 10001;
    };
  };

  # Setup the data directory declaratively, (see inspiration here:
  # https://discourse.nixos.org/t/creating-directories-and-files-declararively/9349
  # https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
  systemd.tmpfiles.rules = [
    "d ${gitea_data_dir} 0755 gitea podman"
    "d ${gitea_config_dir} 0755 gitea podman"
    "L+ ${podman_shim_path} 0755 root root - ${pkgs.podman}/bin/podman"
    "L+ ${gitea_shell_path} 0755 root root - ${gitea_shell}/bin/gitea_shell"
  ];

  # Setup the container
  virtualisation.oci-containers.containers.gitea = {
    image = "gitea/gitea:latest-rootless";
    autoStart = true;
    user = "${builtins.toString config.users.users.gitea.uid}:${builtins.toString config.users.groups.podman.gid}";
    environment = {
      USER_UID = "${builtins.toString config.users.users.gitea.uid}";
      USER_GID = "${builtins.toString config.users.groups.podman.gid}";
    };
    volumes = [
      "${gitea_data_dir}:/var/lib/gitea"
      "${gitea_config_dir}:/etc/gitea"
      #"/etc/timezone:/etc/timezone:ro"
      "/etc/localtime:/etc/localtime:ro"
    ];
    labels = {
      "traefik.http.routers.gitea.rule" = "Host(`git.home`)";
      "traefik.http.routers.gitea.tls" = "true";
      "traefik.http.routers.gitea.tls.certresolver" = "internal";
      "traefik.http.services.gitea.loadbalancer.server.port" = "3000";
    };
  };

  # Possible way to have this whole container run by a specific user (from host's perspective)
  # systemd.services.podman-gitea.serviceConfig.User = "gitea";
  # Wish we could get this to work nicely, then I wouldn't need to fuck with sudo permissions...

  security.sudo = {
    enable = true;
    extraRules = [
      # Allow execution of "/home/root/secret.sh" by user `backup`, `database`
      # and the group with GID `1006` without a password.
      {
        users = ["gitea"];
        commands = [
          {
            command = "${gitea_shell_path}";
            options = ["SETENV" "NOPASSWD"];
          }
          {
            command = "${podman_shim_path}";
            options = ["SETENV" "NOPASSWD"];
          }
        ];
      }
    ];
  };

  # Setup SSH passthrough for git operations
  services.openssh = {
    enable = true;
    extraConfig = ''
      Match User gitea
        PasswordAuthentication no
        KbdInteractiveAuthentication no
        AuthorizedKeysCommandUser root
        AuthorizedKeysCommand /run/wrappers/bin/sudo ${podman_shim_path} exec -i gitea /usr/local/bin/gitea keys -e git -u git -t %t -k %k
    '';
  };
}
