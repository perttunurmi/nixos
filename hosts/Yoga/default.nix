# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
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
    ../../system/desktop/default.nix

    ../../system/services/docker.nix
    ../../system/services/nginx.nix
    ../../system/services/virtualization.nix
    ../../system/services/samba.nix
  ];

  services.nfs.server.enable = true;
  networking.firewall.allowedTCPPorts = [ 2049 ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Yoga";
  networking.networkmanager.enable = lib.mkForce false;

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
        IdleAction= "hybrid-sleep";
      };
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.src_valid_mark" = 1;
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  networking.firewall.enable = lib.mkDefault true;

  system.stateVersion = "25.05";
}
