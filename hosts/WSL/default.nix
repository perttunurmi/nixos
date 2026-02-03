{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../system/configuration.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.firewall.enable = false;

  programs.nix-ld.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  networking.hostName = "nixos";

  environment.systemPackages = with pkgs; [
    pika-backup
    neovim
    git
    wget
    stow
    just
  ];

  services.openssh.ports = lib.mkForce [2222];

  system.stateVersion = "25.05";
}
