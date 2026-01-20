# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./packages.nix
  ];

  # Default to latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Add home lan rootCA
  security.pki = {
    certificateFiles = [
      ../../certs/home-lan-rootCA.pem
    ];
  };

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-44387a08-414f-4699-9086-b8a4a3972a7f".device = "/dev/disk/by-uuid/44387a08-414f-4699-9086-b8a4a3972a7f";
  boot.initrd.luks.devices."luks-44387a08-414f-4699-9086-b8a4a3972a7f".keyFile = "/crypto_keyfile.bin";

  # Enable TRIM for SSD maintenance
  services.fstrim.enable = true;

  networking.hostName = "xps-laptop"; # Define your hostname.
  programs.nm-applet.enable = true; # Enable the nm-applet for NetworkManager
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
  console = {
    keyMap = "uk";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkb = {
      options = "ctrl:nocaps";
      layout = "gb";
    };

    # Enable Intel Proprietary Drivers.
    # videoDrivers = [ "intel" ];

    # Enable touchpad support.
    synaptics.enable = false;

    # Enable i3
    windowManager.i3.enable = true;

    # Try disabling Desktop management
    displayManager = {
      lightdm = {
        enable = true;
        greeters.enso.enable = true;
        greeters.gtk.enable = false;
        greeters.pantheon.enable = false;
        greeters.mini.enable = false;
        greeters.tiny.enable = false;
        # background = /home/sam/.config/home-manager/backgrounds/pexels-kelly-lacy-2538504.jpg;
        background = ../../backgrounds/pexels-kelly-lacy-2538504.jpg;
      };
      startx.enable = false;
      # ly.enable = true;
    };
    desktopManager.wallpaper.mode = "scale";
  };
  services.displayManager.defaultSession = "none+i3";

  services.earlyoom.enable = true;

  security.sudo.extraConfig = "Defaults pwfeedback";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad = {
      clickMethod = "clickfinger";
      middleEmulation = true;
      naturalScrolling = false;
      scrollMethod = "twofinger";
      tapping = true;
    };
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [pkgs.gutenprint pkgs.gutenprintBin];
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sam = {
    isNormalUser = true;
    description = "Sam Martin-Brown";
    extraGroups = [
      "libvirtd"
      "wheel"
      "networkmanager"
      "adbusers"
    ];
    shell = pkgs.zsh;
  };
  nix.settings.trusted-users = [ "sam" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = [] # See packages.nix imported at top;

  # Enable ZSH.
  programs.zsh = {
    enable = true;
  };

  # Setup Fonts.
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # (nerdfonts.override {fonts = ["FiraCode" "FiraMono" "Noto"];})
      nerd-fonts.fira-mono
      nerd-fonts.fira-code
      fira
      nerd-fonts.noto
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
    };
    allowSFTP = true;
  };

  # Enable Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # Setup access to yubikey
  services.udev.packages = [
    pkgs.yubikey-personalization
    pkgs.libu2f-host

    # pkgs.android-udev-rules
  ];
  services.pcscd.enable = true;

  # Enables Upower, which can act on battery levels.
  services.upower = {
    enable = true;
    criticalPowerAction = "HybridSleep";
  };

  # Firmware update server
  services.fwupd = {
    enable = true;
  };

  # Allow various tools to save their settings etc.
  programs.dconf.enable = true;

  # GVFS userspace virtual file system
  services.gvfs.enable = true;

  # picom (fomerly compton) - compositor
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 10;
    vSync = true;
  };

  # Mounted file-systems  (Uses NFSv4)
  fileSystems."/media/Multimedia" = {
    device = "nas.home:Multimedia";
    fsType = "nfs4";
    options = ["rsize=1048576" "wsize=1048576" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  # Thumbnail service
  services.tumbler.enable = true;

  # Enable docker daemon
  #virtualisation.docker.enable = true;

  # Setup virtualisation via KVM + Libvirt.
  virtualisation.libvirtd.enable = true;
  # Tweak KVM settings for macOS guests
  environment.etc = {
    "modprobe.d/kvm.conf" = {
      text = ''
        # KVM tweaks to support macOS VM guests.
        options kvm_intel nested=1
        options kvm_intel emulate_invalid_guest_state=0
        options kvm ignore_msrs=1 report_ignored_msrs=0
      '';
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    8000
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
