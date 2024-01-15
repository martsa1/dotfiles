{
  description = "Home Manager configuration of sam";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: {
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
      };

      "sam@xps-laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./machines/xps_laptop/default.nix];
      };

      "sam.martin@dev-mac" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [./machines/mac_dev/default.nix];
      };
    };
  };
}
