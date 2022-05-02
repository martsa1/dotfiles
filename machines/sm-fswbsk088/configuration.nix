# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Pull home-manager package
      #"${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos"
      #<home-manager/nixos>  # Ensure the channel is added, for this to work...
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

  # Enable TRIM for SSD maintenance
  services.fstrim.enable = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  programs.nm-applet.enable = true;  # Enable the nm-applet for NetworkManager

  networking.hostName = "sm-fswbsk088"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
    #videoDrivers = [ "intel" ];

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
    drivers = [ pkgs.gutenprint pkgs.gutenprintBin ];
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
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
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
      nerdfonts
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
    forwardX11 = true;
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
  };

  ## Mounted file-systems  (Uses NFSv4)
  #fileSystems."/media/Multimedia" = {
  #  device = "nas.home:Multimedia";
  #  fsType = "nfs4";
  #  options = [ "rsize=1048576" "wsize=1048576" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  #};

  # Thumbnail service
  services.tumbler.enable = true;

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

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
      dates = [ "weekly" ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

