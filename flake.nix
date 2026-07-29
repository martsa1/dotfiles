{
  description = "Home Manager configuration of sam";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    # nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";

    # GitOps pull-based deployment (runs on each host)
    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    # Shared utility inputs — pinned once here and followed by everything that
    # uses them, so the lock keeps a single node for each instead of spawning
    # nixpkgs_2 / systems_2 / treefmt-nix_2 duplicates.
    systems.url = "github:nix-systems/default";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative homebrew setup
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Encrypted secrets (age) committed to the repo; hosts decrypt from their
    # SSH host keys. Used for the k3s join token and future secrets.
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    pulseaudio-listener = {
      url = "github:martsa1/pulseaudio-source-listener";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };
  };

  outputs = {
    self,
    comin,
    flake-utils,
    home-manager,
    homebrew-cask,
    homebrew-core,
    nix-darwin,
    nix-homebrew,
    nixgl,
    nixpkgs,
    pulseaudio-listener,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Build a NixOS system, auto-injecting every module in `nixosModules` plus
    # sops-nix, so hosts opt in via `sm.<name>.enable = true` with no per-host
    # import line. `modules` here carries host-specific extras (home-manager, comin).
    mkNixos = modules:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          modules
          ++ builtins.attrValues self.nixosModules
          ++ [inputs.sops-nix.nixosModules.sops];
      };
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

      "samuel@samuel-mac" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [
          ({
            nixpkgs.overlays = outputs.overlays;
          })

          ./machines/mac_dev/default.nix
        ];
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "sam@xps-laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./machines/xps_laptop/default.nix];
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "sam@k1" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./machines/k1/default.nix];
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };

    # Custom home-manager modules
    homeModules = import ./modules;

    # Custom NixOS modules (auto-injected into every host via mkNixos)
    nixosModules = import ./modules/nixos;

    # NixOS configs. mkNixos auto-injects all `nixosModules` + sops-nix; the
    # list passed here is host-specific extras only.
    nixosConfigurations = {
      laptop-server = mkNixos [
        ./machines/laptop-server/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];

      xps-laptop = mkNixos [
        ./machines/xps_laptop/configuration.nix
        # home-manager.nixosModules.home-manager
        # {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        # }
      ];

      k1 = mkNixos [
        ./machines/k1/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        # GitOps: comin runs on this host, polls the dotfiles repo and
        # rebuilds nixosConfigurations.k1 when main changes. k1 only for now.
        # Public HTTPS remote — the comin service needs no credentials as
        # long as martsa1/dotfiles stays public. (If it goes private, comin
        # will need a read token configured.)
        comin.nixosModules.comin
        {
          services.comin = {
            enable = true;
            remotes = [
              {
                name = "github";
                url = "https://github.com/martsa1/dotfiles.git";
                branches.main.name = "main";
              }
            ];
          };
        }
      ];
    };

    darwinConfigurations =  {
      "samuel-mac" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs outputs; };

        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          ./machines/mac_dev/homebrew.nix
          ./machines/mac_dev/configuration.nix
        ];
      };
    };

    # packages = {
    #   ${curSystem} = nixpkgs.legacyPackages.${curSystem};
    # };
  };
}
