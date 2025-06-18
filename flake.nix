{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen-browser = {
    #   url = "github:0xc000022070/zen-browser-flake";
    #   # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
    #   # to have it up-to-date or simply don't specify the nixpkgs input  
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.T480s = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.users.perttu = import ./home.nix;
        }

        # This module works the same as the `specialArgs` parameter we used above
        # choose one of the two methods to use
        # { _module.args = { inherit inputs; };}
      ];
    };
  };
}
