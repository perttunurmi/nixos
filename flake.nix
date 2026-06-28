{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    hardware.url = "github:nixos/nixos-hardware";

    stylix.url = "github:nix-community/stylix/release-26.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    secrets = {
      url = "git@github.com:perttunurmi/secrets.git";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-wsl,
      stylix,
      agenix,
      secrets,
      ...
    }:
    {
      nixosConfigurations =
        let
          mkHost =
            {
              hostPath,
              username ? "perttu",
              wsl ? false,
              server ? false,
              desktop ? false,
              extraSpecialArgs ? { },
            }:
            let
              specialArgs = {
                inherit username;
                inherit wsl;
                inherit server;
                inherit desktop;
                inherit agenix;
                inherit secrets;
                inherit self;
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
                  wsl.startMenuLaunchers = false;
                  wsl.interop.register = wsl;
		  wsl.ssh-agent.enable = wsl;
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
        in
        {
          T480s = mkHost {
            hostPath = ./hosts/T480s;
            extraSpecialArgs = { inherit inputs; };
            desktop = true;
          };

          nixos = mkHost {
            hostPath = ./hosts/WSL;
            extraSpecialArgs = { inherit inputs; };
            wsl = true;
          };

          Fujitsu = mkHost {
            hostPath = ./hosts/Fujitsu;
            extraSpecialArgs = { inherit inputs; };
            server = true;
          };

          Yoga = mkHost {
            hostPath = ./hosts/Yoga;
            extraSpecialArgs = { inherit inputs; };
            server = true;
          };
        };
    };
}
