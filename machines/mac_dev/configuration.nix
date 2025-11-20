{ pkgs, config, ... }: {
  # Note that home-manager stuff is mentioned in the overall system flake.

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    [
      git
      home-manager # I want to be able to manage my user without needing to elevate to root all the time...
    ];

  users.users.samuel = {
    home = "/Users/samuel";
  };

  # Nix settings
  nix = {

    # nix.package = pkgs.nix;

    # Necessary for using flakes on this system.
    settings = {
      experimental-features = "nix-command flakes";
      # auto-optimise-store = true;
      # optimise.automatic = true;

      trusted-users = [
        "root"
        "samuel"
      ];
    };
    # Already set using symlink to nix.conf from dotfiles.

    # Store garbage collection stuff
    gc = {
      automatic = true;
    };


    # Configure Nix Path so that home-manager can be used outside of nix-darwin stuff...
    # nixPath = [
    #   {
    # 	darwin-config = "$HOME/.config/nix-darwin/configuration.nix";
    #   }
    #   {
    #     home-manager = "$HOME/.config/home-manager/home.nix";
    #   }
    #   "/nix/var/nix/profiles/per-user/root/channels"
    # ];

  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  system = {
    #checks.verifyNixPath = true;

    # Set Git commit hash for darwin-version.
    configurationRevision = config.rev or config.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;


    # defaults = {
    #   dock = {
    #     autohide = true;
    #   };
    # };
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
