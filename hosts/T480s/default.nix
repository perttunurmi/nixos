{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ../../system/configuration.nix

    ./hardware/throttled.nix
    ./hardware/thinkfan.nix

    ./hardware/nvidia.nix
    # ./hardware/disable_nvidia.nix
    ./hardware/disable_touchscreen.nix

    ../../system/desktop/default.nix
    ../../system/services/docker.nix
  ];

  boot = {
    initrd.luks.devices."luks-3a99b308-6f51-4953-b4e0-68d4dc1e6af4".device =
      "/dev/disk/by-uuid/3a99b308-6f51-4953-b4e0-68d4dc1e6af4";
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

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

  networking.hostName = "T480s";

  environment.systemPackages = with pkgs; [
    scrcpy
    powertop
    openconnect
  ];

  services.thermald.enable = true;

  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # Reduce swapping to disk
    "vm.vfs_cache_pressure" = 50; # Keep inode/dentry caches longer
  };

  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitchExternalPower = "ignore";
      };
    };
  };

  system.stateVersion = "25.05";
}
