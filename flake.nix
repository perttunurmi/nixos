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

    # Sops (secret manager)
    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    mysecrets = {
      url = "git@github.com:perttunurmi/secrets.git";
      flake = false;
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixos-wsl,
    stylix,
    ...
  }: {
    nixosConfigurations = let
      mkHost = {
        hostPath,
        username ? "perttu",
        wsl ? false,
        server ? false,
        extraSpecialArgs ? {},
      }: let
        specialArgs =
          {
            inherit username;
            inherit wsl;
            inherit server;
          }
          // extraSpecialArgs;
        inherit username;
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
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
          ];
        };
    in {
      T480s = mkHost {
        hostPath = ./hosts/T480s;
        extraSpecialArgs = {inherit inputs;};
      };

      NixOS = mkHost {
        hostPath = ./hosts/NixOS;
        extraSpecialArgs = {inherit inputs;};
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
