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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option

  services.openssh.ports = lib.mkForce [2222];

  system.stateVersion = "25.05"; # Did you read the comment?
}
