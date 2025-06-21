{ config, lib, pkgs, ... }:
# sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable && sudo nix-channel --update
{
  imports = [
    <nixos-wsl/modules>
    (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")

    ../../modules/system.nix
  ];

  programs.nix-ld.enable = true;

  wsl = {
    enable = true;
    defaultUser = "perttu";
    docker-desktop.enable = true;
    wslConf.network.hostname = "WSL";
  };

  # vscode server for wsl and ssh
  services.vscode-server.enable = true;

  networking.firewall = {
    enable = false;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
    };
  };

  environment.systemPackages = with pkgs;
    [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.47.2";
          sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
        }
      ];
    })
    ];

  programs.java = { enable = true; };

  environment = {
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  users.users.perttu.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCWzvRxBB4hWnes/OLWl7Mle5VYlnwNsd8zko8IrZ2/ perttu@nixos"
  ];

  system.stateVersion = "25.05";
}
