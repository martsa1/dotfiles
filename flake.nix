{
  description = "Home Manager configuration of sam";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    nixgl,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    overlays = [
      inputs.neovim-nightly-overlay.overlay
      inputs.nixgl.overlay

      (final: prev: {
        dunst-dracula-theme = prev.callPackage ./pkgs/dunst-dracula-theme {};
        gtk-dracula-icons = prev.callPackage ./pkgs/gtk-dracula-icons {};
        i3-config = prev.callPackage ./pkgs/i3-config {};
        polybar-launcher = prev.callPackage ./pkgs/polybar-launcher {};
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

      "sam.martin@dev-mac" = home-manager.lib.homeManagerConfiguration {
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
  };
}
