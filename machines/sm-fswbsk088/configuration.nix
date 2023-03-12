# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Pull home-manager package
    #"${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos"
    #<home-manager/nixos>  # Ensure the channel is added, for this to work...

    # Steam config.
    ./steam.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = {
      root = {
        device = "/dev/nvme0n1p1";
        preLVM = true;
      };
    };
  };

  # Add home lan rootCA
  security.pki = {
    certificateFiles = [
      ../../certs/home-lan-rootCA.pem
    ];
  };

  # Set time zone.
  time.timeZone = "Europe/London";

  # Enable TRIM for SSD maintenance
  services.fstrim.enable = true;

  # Configure networking stuff
  networking = {
    # networking.hostName = "nixos"; # Define your hostname.
    hostName = "sm-fswbsk088"; # Define hostname.

    # Try to use networkd and NetworkManager at the same time.
    useDHCP = false;
    useNetworkd = true;

    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true; # Easiest to use and most distros use this by default.
      dns = "systemd-resolved"; # TODO - See if we can/should still use systemd-based DNS.
    };

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    firewall = {
      enable = true;
      checkReversePath = "loose"; # Needed by tailscale
    };

    # For now, just disable ipv6...
    enableIPv6 = false;
  };
  programs.nm-applet.enable = true; # Enable nm-applet for NetworkManager

  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    domains = ["home"];

    # Specifying this blocks use of compile-time defaults in
    # systemd-resolved...
    fallbackDns = [""];
  };

  # See more at man systemd.network
  #systemd.network.network = {
  #  DHCP = "yes";
  #};
  systemd.network.networks = {
    # Config for all useful interfaces
    #"40-wired" = {
    #  enable = true;
    #  name = "en*";
    #  dhcpV4Config.RouteMetric = 1024; # Better be explicit

    #  networkConfig = {
    #    DNSDefaultRoute = "yes";
    #    DefaultRouteOnDevice = "yes";
    #    DHCP = "yes";
    #    DNSSEC = "yes";
    #    DNSOverTLS = "yes";
    #    #DNS = [ "1.1.1.1" "1.0.0.1" ];
    #  };
    #};
    # Seems to conflict somewhat with NetworkManager...
    #"40-wireless" = {
    #  enable = true;
    #  name = "wl*";
    #  networkConfig = {
    #    DHCP = "yes";
    #    DNSDefaultRoute = "yes";
    #    DefaultRouteOnDevice = "yes";
    #  };
    #  dhcpV4Config.RouteMetric = 2048; # Prefer wired
    #  dhcpV4Config = {
    #    #Anonymize = "yes";
    #    UseDNS = "yes";
    #    UseDomains = "route";
    #    UseHostname = "no";
    #    UseMTU = "yes";
    #    UseNTP = "yes";
    #    UseRoutes = "yes";
    #  };
    #};
    "globalprotect" = {
      enable = true;
      name = "globalprotect";
      DHCP = "no";

      domains = [
        "gtn"
        "f-secure.com"
        "fi.f-secure.com"
        "sp.fscdc.net"
        "mwrinfosecurity.com"
        "fsxt.net"
        "fsapi.com"
      ];
      matchConfig = {
        Name = "globalprotect";
      };

      linkConfig = {
        Unmanaged = "no";
      };

      networkConfig = {
        Description = "F-Secure GlobalProtect";
        DNSDefaultRoute = "no";
        DefaultRouteOnDevice = "no";
      };

      dhcpV4Config = {
        #Anonymize = "yes";
        UseDNS = "yes";
        UseDomains = "route";
        UseHostname = "no";
        UseMTU = "yes";
        UseNTP = "yes";
        UseRoutes = "yes";
      };
    };
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Setup X11
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "gb";
    xkbOptions = "ctrl:nocaps";

    # Enable Intel Proprietary Drivers.
    videoDrivers = ["intel"];

    # Enable touchpad support.
    synaptics.enable = false;
    libinput = {
      enable = true;
      touchpad = {
        clickMethod = "clickfinger";
        middleEmulation = true;
        naturalScrolling = false;
        scrollMethod = "twofinger";
        tapping = true;
      };
    };

    # Enable i3
    windowManager.i3.enable = true;

    # Try disabling Desktop management
    displayManager = {
      defaultSession = "none+i3";
      lightdm = {
        enable = true;
        greeters.enso.enable = true;
        greeters.gtk.enable = false;
        greeters.pantheon.enable = false;
        greeters.mini.enable = false;
        greeters.tiny.enable = false;
        background = /home/sam/.config/nixpkgs/backgrounds/pexels-kelly-lacy-2538504.jpg;
      };
      startx.enable = false;
      # ly.enable = true;
    };
    desktopManager.wallpaper.mode = "scale";
  };

  # Setup autorandr to manage display configs.
  services.autorandr = {
    enable = true;
    defaultTarget = "default";
  };

  security.sudo.extraConfig = "Defaults pwfeedback";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [pkgs.gutenprint pkgs.gutenprintBin];
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  #hardware.pulseaudio = {
  #  enable = true;
  #  systemWide = false;
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sam = {
    createHome = true;
    extraGroups = ["kvm" "libvirtd" "network" "networkmanager" "wheel"]; # Enable ‘sudo’ for the user.
    group = "users";
    home = "/home/sam";
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    firefox
    neovim
    #opensnitch-ui
    wget
  ];

  # Enable ZSH.
  programs.zsh = {
    enable = true;
  };

  # Setup Fonts.
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode" "FiraMono" "Noto"];})
      fira-mono
      fira-code
      fira
      noto-fonts
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
      forwardX11 = true;
    };
    allowSFTP = true;
  };

  # Setup access to yubikey
  services.udev.packages = [
    pkgs.yubikey-personalization
    pkgs.libu2f-host
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
    backend = "glx";
  };

  # Setup Application firewall
  #services.opensnitch = {
  #  enable = true;

  #  settings = {
  #    DefaultAction = "deny";
  #    DefaultDuration = "once";
  #    Firewall = "nftables";
  #    InterceptUnknown = true;
  #    LogLevel = 1;
  #    ProcMonitorMethod = "ebpf";
  #  };
  #};

  ## Mounted file-systems  (Uses NFSv4)
  #fileSystems."/media/Multimedia" = {
  #  device = "nas.home:Multimedia";
  #  fsType = "nfs4";
  #  options = [ "rsize=1048576" "wsize=1048576" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  #};

  # Thumbnail service
  services.tumbler.enable = true;

  # Enable Tailscale
  services.tailscale = {
    enable = true;
  };

  # Enable docker daemon
  #virtualisation.docker.enable = true;

  # Allow non-free packages
  nixpkgs.config.allowUnfree = true;

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

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # enable this when you need to mess with something, but leave it commented
  # by-default.
  #nixpkgs.config.allowBroken = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
