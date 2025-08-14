{
  username,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./packages.nix
    ./overlays.nix

    ../users/perttu/default.nix
    ../users/root/default.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’!
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "${username}"
      "gamemode"
      "networkmanager"
      "wheel"
      "docker"
      "audio"
      "video"
      "plugdev"
      "input"
      "lp"
      "scanner"
      "libvirt"
      "kvm"
      "wireshark"
      "adbusers"
      "samba"
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

  console = {
    earlySetup = true;
    # font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    # packages = with pkgs; [terminus_font];
    keyMap = "us";
  };

  # given the users in this list the right to specify additional substituters via:
  #    1. `nixConfig.substituers` in `flake.nix`
  #    2. command line args `--options substituers http://xxx`
  nix.settings.trusted-users = [username];

  # customise /etc/nix/nix.conf declaratively via `nix.settings`
  nix.settings = {
    # enable flakes globally
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    builders-use-substitutes = true;
  };

  # do garbage collection weekly to keep disk usage "low"
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # please don't optimize on every build
  nix.settings.auto-optimise-store = false;

  # but optimize while I drink my morning coffee
  nix.optimise.automatic = true;
  # Default to 09:00 for personal convenience; override via nix.optimise.dates if needed.
  nix.optimise.dates = lib.mkDefault ["09:00"];
}
