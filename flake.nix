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
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # home-manager
    home-manager.url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # zen-browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # snapd
    nix-snapd.url = "github:nix-community/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    zen-browser,
    nix-snapd,
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
              home-manager.users.${username} = import ./home/home.nix;
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
      NixOS = mkHost {
        hostPath = ./hosts/NixOS;
        username = "perttu";
        extraSpecialArgs = {inherit inputs;};
      };
    };
  };
}
