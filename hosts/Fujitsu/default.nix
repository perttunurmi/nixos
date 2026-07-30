{
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../system/configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "Fujitsu";

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "${username}";
    configDir = "/home/${username}/.config/syncthing";
    dataDir = "/home/${username}/share";
  };

  services.nfs.server.enable = true;

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.src_valid_mark" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking.networkmanager.enable = lib.mkForce false;

  time.timeZone = lib.mkDefault "Europe/Helsinki";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  i18n.extraLocaleSettings = lib.mkDefault {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  services.xserver.xkb = lib.mkDefault {
    layout = "us";
    variant = "";
  };

  users.users.${username} = lib.mkDefault {
    isNormalUser = true;
    description = "Perttu Nurmi";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;
  environment.systemPackages = with pkgs; [
    cargo
    neovim
    vim
    wget
    git
  ];

  services.openssh.enable = lib.mkDefault true;
  networking.firewall.enable = lib.mkDefault true;

  system.stateVersion = "25.05";
}
