{
  description = "Home Manager configuration of sam";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    # nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";

    # Preserved as the last commit to grab nodeJS v18 from - needed for work stuff.
    nixpkgs_old.url = "github:nixos/nixpkgs/44b4123568a045a955db48c4965f0dcf4764e9c2";


    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pulseaudio-listener = {
      url = "github:martsa1/pulseaudio-source-listener";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs_old,
    home-manager,
    flake-utils,
    nixgl,
    pulseaudio-listener,
    wezterm,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    overlays = [
      # inputs.neovim-nightly-overlay.overlays.default
      inputs.nixgl.overlay

      (final: prev: {
        dunst-dracula-theme = prev.callPackage ./pkgs/dunst-dracula-theme {};
        # gtk-dracula-icons = prev.callPackage ./pkgs/gtk-dracula-icons {};
        i3-config = prev.callPackage ./pkgs/i3-config {};
        polybar-launcher = prev.callPackage ./pkgs/polybar-launcher {};
        polybar-mute = prev.callPackage ./pkgs/polybar-mute {};
        polybar-spotify = prev.callPackage ./pkgs/polybar-spotify {};
        rofi-dracula-theme = prev.callPackage ./pkgs/rofi-dracula-theme {};
      })
    ];

    # inside a home-manager.lib.homeManagerConfiguration:
    #  # Specify your home configuration modules here, for example,
    #  # the path to your home.nix.
    #
    #  modules = [./machines/xps_laptop/default.nix];
    #
    #  # Optionally use extraSpecialArgs
    #  # to pass through arguments to home.nix
    homeConfigurations = {
      "sam@fswbsk088" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./machines/sm-fswbsk088/default.nix];
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "sam@laptop-server" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./machines/laptop-server/default.nix];
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "samuel@samuel-martin-brown" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [./machines/mac_dev/default.nix];
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "sam@xps-laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./machines/xps_laptop/default.nix];
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };

    # Custom home-manager modules
    homeModules = import ./modules;

    # NixOS configs.
    nixosConfigurations = {
      laptop-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/laptop-server/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };

    # packages = {
    #   ${curSystem} = nixpkgs.legacyPackages.${curSystem};
    # };
  };
}
