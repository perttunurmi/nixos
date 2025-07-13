{
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.enable = true;
  services.displayManager.defaultSession = lib.mkForce "cinnamon";

  services.fwupd.enable = true;

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "Fujitsu"; # Define your hostname.

  system.stateVersion = "25.05"; # Did you read the comment?
}
