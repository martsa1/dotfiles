# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Add home lan rootCA
  security.pki = {
    certificateFiles = [
      ../../certs/home-lan-rootCA.pem
    ];
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable TRIM for SSD maintenance
  services.fstrim.enable = true;

  networking.hostName = "k1"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # EarlyOOM helps stop system becoming unrecoverable
  services.earlyoom.enable = true;

  security.sudo.extraConfig = "Defaults pwfeedback";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sam = {
    isNormalUser = true;
    description = "sam";
    extraGroups = [ "libvirtd" "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Enable ZSH.
  programs.zsh = {
    enable = true;
  };

  nix.settings.trusted-users = [ "sam" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enables Upower, which can act on battery levels.
  services.upower = {
    enable = true;
    criticalPowerAction = "HybridSleep";
  };

  # Firmware update server
  services.fwupd = {
    enable = true;
  };

  # Mounted file-systems  (Uses NFSv4)
  fileSystems."/media/Multimedia" = {
    device = "nas.home:Multimedia";
    fsType = "nfs4";
    options = ["rsize=1048576" "wsize=1048576" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  fileSystems."/media/backups" = {
    device = "nas.home:backups";
    fsType = "nfs4";
    options = ["rsize=1048576" "wsize=1048576" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  # Various options for the nix package management tooling
  nix = {
    # Configure NixOS to automatically collect garbage packages etc.
    gc = {
      automatic = true;
      dates = "weekly";
      persistent = true;
      options = "--delete-older-than 60d";
      randomizedDelaySec = "10min";
    };

    optimise = {
      automatic = true;
      dates = ["weekly"];
    };

    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # --- k3s cluster (k1 is the control-plane server) -------------------------
  # Join token is decrypted at activation by sops-nix from secrets/secrets.yaml
  # (see ../../secrets and the root .sops.yaml). The sm.k3s module lives in
  # modules/nixos and is auto-injected by mkNixos in flake.nix.
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.secrets.k3s_token = {
    sopsFile = ../../secrets/secrets.yaml;
    restartUnits = ["k3s.service"];
  };

  sm.k3s = {
    enable = true;
    role = "server";
    tokenFile = config.sops.secrets.k3s_token.path;
    # Lets kubectl from other LAN hosts reach the API via the hostname.
    tlsSan = ["k1.home"];
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
