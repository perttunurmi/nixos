{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ./hardware/throttled.nix
    ./hardware/thinkfan.nix
    ./hardware/nvidia.nix
    ./hardware/secureboot.nix

    ../../system/desktop/default.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;

    efi = {
      canTouchEfiVariables = true;
      # efiSysMountPoint = "/boot";
    };

    grub.enable = false;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot = {
    plymouth = {
      enable = false;
      theme = "bgrt";
      themePackages = with pkgs; [
        nixos-bgrt-plymouth
        # By default we would install all themes
        # (adi1090x-plymouth-themes.override {
        #   selected_themes = [ "rings" ];
        # })
      ];
    };

    # Enable "Silent boot"
    # consoleLogLevel = 3;
    # initrd.verbose = false;
    # kernelParams = [
    #   "quiet"
    #   "splash"
    #   "boot.shell_on_fail"
    #   "udev.log_priority=3"
    #   "rd.systemd.show_status=auto"
    # ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed

    # loader.timeout = 1;
  };

  networking.hostName = "T480s"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  environment.systemPackages = with pkgs; [
    powertop
  ];

  powerManagement.enable = true;
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;

  services.logind.lidSwitch = "lock";
  services.logind.lidSwitchExternalPower = "lock";
  services.logind.lidSwitchDocked = "ignore";

  system.stateVersion = "25.05";
}
