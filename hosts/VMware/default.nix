{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "VMware"; # Define your hostname.
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.

  services.xserver.videoDrivers = ["vmware"];
  virtualisation.vmware.guest.enable = true;

  environment.systemPackages = with pkgs; [
    open-vm-tools
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
