{
  description = "NixOS configuration";

  inputs = {
    # Official nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    stylix.url = "github:nix-community/stylix/release-25.05";

    # Home-manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Zen-browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # Windows subsystem for linux
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    # Lanzaboote (secure boot)
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    mysecrets = {
      url = "git@github.com:perttunurmi/secrets.git";
      flake = false;
    };

    dwm-config = {
      # Use the nixos repo as the dwm package source
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
    dwm-config,
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
            inherit dwm-config;
          }
          // extraSpecialArgs;
        inherit username;
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            agenix.nixosModules.default
            stylix.nixosModules.stylix
            nixos-wsl.nixosModules.default
            {
              wsl.enable = wsl;
              wsl.defaultUser = "${username}";
              wsl.docker-desktop.enable = wsl;
              wsl.startMenuLaunchers = wsl;
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
    };
  };
}
