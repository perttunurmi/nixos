{
  description = "NixOS configuration";
  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    # substituers will be appended to the default substituters when fetching packages
    # nix com    extra-substituters = [munity's cache server
    extra-substituters = ["https://nix-community.cachix.org"];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # home-manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # zen-browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # snapd
    nix-snapd.url = "github:nix-community/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    zen-browser,
    nix-snapd,
    nixpkgs-unstable,
    ...
  }: {
    nixosConfigurations = let
      mkHost = {
        hostPath,
        username,
        extraSpecialArgs ? {},
      }: let
        specialArgs =
          {
            inherit username;
          }
          // extraSpecialArgs;
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            nix-snapd.nixosModules.default
            {services.snap.enable = true;}
            hostPath
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };
    in {
      T480s = mkHost {
        hostPath = ./hosts/T480s;
        username = "perttu";
        extraSpecialArgs = {inherit inputs;};
      };
      VMware = mkHost {
        hostPath = ./hosts/VMware;
        username = "perttu";
        extraSpecialArgs = {inherit inputs;};
      };
      Fujitsu = mkHost {
        hostPath = ./hosts/Fujitsu;
        username = "perttu";
        extraSpecialArgs = {inherit inputs;};
      };
    };
  };
}
