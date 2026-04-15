{
  username,
  lib,
  pkgs,
  wsl,
  config,
  desktop,
  ...
}:
{
  imports = [
    ./packages.nix
    ./agenix.nix
    ./overlays.nix
    ./settings.nix

    ./users/perttu/default.nix
    ./users/root/default.nix
  ]
  ++ (
    if desktop then
      [
        ./theming/stylix.nix
      ]
    else
      [ ]
  );

  services.tailscale.enable = true;
  services.tailscale.permitCertUid = "caddy";

  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    checkReversePath = "loose";
  };

  # networking.nameservers = ["100.100.100.100" "8.8.8.8" "1.1.1.1"];
  # networking.search = ["tail31079d.ts.net"];

  # services.avahi = {
  #   enable = true;
  #   allowPointToPoint = true;
  # };

  boot.supportedFilesystems = [ "nfs" ];

  programs.bash.enable = true;
  users.defaultUserShell = pkgs.bash;

  users.users.${username} = lib.mkDefault {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "${username}"
      "wheel"
      "keyd"
    ];
  };

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

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  networking.firewall.enable = lib.mkDefault true;
  networking.nftables.enable = lib.mkDefault true;
  networking.wireless.enable = lib.mkDefault false;
  networking.networkmanager = lib.mkDefault {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect
    ];
  };

  # This improves boot times by telling systemd not to wait for internet connection
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  hardware.graphics = lib.mkDefault {
    enable = true;
    enable32Bit = true;
  };

  console = lib.mkDefault {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };
}
