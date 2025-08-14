{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ./hardware/throttled.nix
    ./hardware/thinkfan.nix
    # ./hardware/nvidia.nix
    ./hardware/disable_nvidia.nix
    ./hardware/secureboot.nix

    ../../system/desktop/default.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-3a99b308-6f51-4953-b4e0-68d4dc1e6af4".device = "/dev/disk/by-uuid/3a99b308-6f51-4953-b4e0-68d4dc1e6af4";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.bootspec.enable = true;

  boot = {
    plymouth = {
      enable = true;
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed

    loader.timeout = 0;
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
  # powerManagement.powertop.enable = true;

  services.power-profiles-daemon.enable = lib.mkForce false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "balanced";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "balanced";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 95;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 80;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };

  # Suspend first then hibernate when closing the lid
  services.logind.lidSwitch = "hibernate";
  # Hibernate on power button pressed
  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "poweroff";

  services.logind.lidSwitchExternalPower = "hybrid-sleep";
  services.logind.lidSwitchDocked = "ignore";

  system.stateVersion = "25.05";
}
