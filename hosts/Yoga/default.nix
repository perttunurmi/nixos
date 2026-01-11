{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../system/configuration.nix

    ../../system/services/docker.nix
    # ../../system/services/virtualization.nix
    ../../system/services/samba.nix
    ../../system/services/immich.nix
    ../../system/services/nginx.nix
    ../../system/services/nextcloud.nix
    ../../system/services/nfs.nix
  ];

  services.nfs.server.enable = true;
  networking.firewall.allowedTCPPorts = [2049 51821];
  networking.firewall.allowedUDPPorts = [51820];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Yoga";
  networking.networkmanager.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    git
  ];

  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchDocked = "ignore";
        LidSwitchExternalPower = "ignore";
        IdleAction = "hybrid-sleep";
      };
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.src_valid_mark" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  environment.enableAllTerminfo = true;

  system.stateVersion = "25.05";
}
