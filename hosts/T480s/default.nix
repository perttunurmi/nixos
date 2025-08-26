{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ../../system/configuration.nix

    ./hardware/throttled.nix
    ./hardware/thinkfan.nix

    # ./hardware/nvidia.nix
    ./hardware/disable_nvidia.nix

    ./hardware/secureboot.nix

    ../../system/desktop/default.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.luks.devices."luks-3a99b308-6f51-4953-b4e0-68d4dc1e6af4".device = "/dev/disk/by-uuid/3a99b308-6f51-4953-b4e0-68d4dc1e6af4";
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    bootspec.enable = true;
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

    loader.timeout = 0;
  };

  networking.hostName = "T480s"; # Define your hostname.

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
      CPU_MAX_PERF_ON_AC = 90;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 85;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 0;
      STOP_CHARGE_THRESH_BAT0 = 85; # 80 and above it stops charging
    };
  };

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };

  system.stateVersion = "25.05";
}
