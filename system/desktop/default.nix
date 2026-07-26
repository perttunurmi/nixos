{
  pkgs,
  username,
  lib,
  ...
}:
{
  imports = [
    ./fonts.nix

    ./environments/i3.nix

    ./services/keyd.nix
    ./services/xserver.nix

    ./udev/wooting.nix

    ./ld.nix
  ];

  services.fwupd.enable = lib.mkDefault true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = lib.mkDefault true;
    touchpad.disableWhileTyping = lib.mkDefault true;
    touchpad.tapping = lib.mkDefault false;
    # services.libinput.touchpad.clickMethod = "buttonareas";
  };

  programs.chromium.enable = true;

  services.flatpak.enable = true;

  xdg = {
    portal = {
      enable = true;

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];

      config = {
        common = {
          default = [
            "gtk"
          ];
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
      };
    };
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  users.users.${username}.packages = with pkgs; [
    python3
    sioyek
    testdisk
    gparted
    pika-backup
    gnome-software
    flatpak
    zed-editor-fhs
    obsidian
    discord
  ];

  programs.steam.enable = true;

  # Whether to enable the RealtimeKit system service, which hands out
  # realtime scheduling priority to user processes on demand.
  # For example, PulseAudio and PipeWire use this to acquire realtime priority.
  security.rtkit.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;

  services.power-profiles-daemon = lib.mkDefault {
    enable = true;
  };

  # i18n.inputMethod = {
  #   enable = true;
  #   type = "ibus";
  #   ibus.engines = with pkgs.ibus-engines; [
  #     /*
  #     any engine you want, for example
  #     */
  #     # anthy
  #   ];
  # };

  services = {
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
      implementation = "broker";
    };

    geoclue2.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # https://wiki.nixos.org/wiki/MTP
    # Mount, trash, and other functionalities
    gvfs = {
      enable = true;
      # package = lib.mkForce pkgs.gnome.gvfs;
    };
    blueman.enable = true;
    udev.packages = with pkgs; [ gnome-settings-daemon ];
  };

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [
      "network.target"
      "sound.target"
    ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;

    allowedTCPPorts = [
      57621
      24800
    ];
    allowedUDPPorts = [
      5353
      24800
      53
      67
    ];
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.seahorse.enable = true; # enable the graphical frontend

  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
