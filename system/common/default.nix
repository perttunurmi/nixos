{
  username,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./packages.nix
    ./overlays.nix
    ./settings.nix
    ./agenix.nix

    ./services/ssh.nix

    ./theming/stylix.nix

    ./users/perttu/default.nix
    ./users/root/default.nix
  ];

  users.users.${username} = lib.mkDefault {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "${username}"
      "wheel"
      "keyd"
    ];
  };

  # Time and locales
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  networking.firewall.enable = lib.mkDefault true;
  networking.networkmanager.enable = lib.mkDefault true;
  networking.wireless.enable = lib.mkDefault false; # Enables wireless support via wpa_supplicant.

  systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [];

  hardware.graphics = lib.mkDefault {
    enable = true;
    enable32Bit = true;
  };

  console = lib.mkDefault {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [terminus_font];
    keyMap = "us";
  };
}
