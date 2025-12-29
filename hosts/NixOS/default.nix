{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./secureboot.nix

    ../../system/configuration.nix

    ../../system/desktop/default.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];
  boot.initrd.kernelModules = ["amdgpu"];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
      editor = false;
      consoleMode = "keep";
    };
    efi.canTouchEfiVariables = true;
    timeout = 5;
  };

  networking.hostName = "NixOS";

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gh
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-57-6.16"
  ];

  system.stateVersion = "25.05";
}
