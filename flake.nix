{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    stylix.url = "github:nix-community/stylix/release-25.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nix-snapd.url = "github:nix-community/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.3";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    mysecrets = {
      url = "git@github.com:perttunurmi/secrets.git";
      flake = false;
    };

    dwm-config = {
      url = "github:perttunurmi/dwm";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixos-wsl,
    stylix,
    agenix,
    nix-snapd,
    ...
  }: {
    nixosConfigurations = let
      mkHost = {
        hostPath,
        username ? "perttu",
        wsl ? false,
        server ? false,
        desktop ? false,
        extraSpecialArgs ? {},
      }: let
        specialArgs =
          {
            inherit username;
            inherit wsl;
            inherit server;
            inherit desktop;
          }
          // extraSpecialArgs;
        inherit username;
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            nix-snapd.nixosModules.default
            {
              services.snap.enable = true;
            }
            agenix.nixosModules.default
            stylix.nixosModules.stylix
            nixos-wsl.nixosModules.default
            {
              wsl.enable = wsl;
              wsl.defaultUser = "${username}";
              wsl.docker-desktop.enable = wsl;
              wsl.startMenuLaunchers = wsl;
              wsl.interop.register = wsl;
            }
            hostPath
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./home/home.nix;
            }
            ({
              config,
              pkgs,
              ...
            }: {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    system = "x86_64-linux";
                    config.allowUnfree = true;
                    config.android_sdk.accept_license = true;
                  };
                })
              ];
            })
          ];
        };
    in {
      T480s = mkHost {
        hostPath = ./hosts/T480s;
        extraSpecialArgs = {inherit inputs;};
        desktop = true;
      };

      NixOS = mkHost {
        hostPath = ./hosts/NixOS;
        extraSpecialArgs = {inherit inputs;};
        desktop = true;
      };

      nixos = mkHost {
        hostPath = ./hosts/WSL;
        extraSpecialArgs = {inherit inputs;};
        wsl = true;
      };

      Fujitsu = mkHost {
        hostPath = ./hosts/Fujitsu;
        extraSpecialArgs = {inherit inputs;};
        server = true;
      };

      Yoga = mkHost {
        hostPath = ./hosts/Yoga;
        extraSpecialArgs = {inherit inputs;};
        server = true;
      };
    };
  };
}
