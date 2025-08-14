{
  pkgs,
  username,
  lib,
  ...
}: {
  imports = [
    ../../system/configuration.nix

    ./fonts.nix
    ./stylix.nix

    # ./gamemode.nix
    # ./gaming/gamemode.nix
    # ./gaming/steam.nix

    ./environments/hyprland.nix
    # ./environments/i3.nix
    # ./environments/qtile.nix

    ../services/xserver.nix
    ../services/keyd.nix
    ../services/ssh.nix
    # ../services/docker.nix
  ];

  services.preload.enable = true;

  services.fwupd.enable = lib.mkDefault true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = lib.mkDefault true;

  services.flatpak.enable = true;
  xdg = {
    portal = {
      enable = true;

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
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
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  users.users.${username}.packages = with pkgs; [
    wg-netmanager
    wireguard-tools
    spotify
    testdisk
    gparted
    pika-backup
    gnome-software
    flatpak
    preload
    obsidian
    vscode.fhs
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions;
        [
          bbenoist.nix
          # ms-python.python
          # ms-azuretools.vscode-docker
          # ms-vscode-remote.remote-ssh
          # ms-toolsai.jupyter
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "remote-ssh-edit";
            publisher = "ms-vscode-remote";
            version = "0.47.2";
            sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
          }
        ];
    })
    discord
    brave
    android-tools
    scrcpy
  ];

  # face for the user
  systemd.tmpfiles.rules = [
    "f+ /var/lib/AccountsService/users/${username}  0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/${username}\\n" # notice the "\\n" we don't want nix to insert a new line in our string, just pass it as \n to systemd
    "L+ /var/lib/AccountsService/icons/${username}  - - - - ${../../users/perttu/face}" # you can replace the ${....} with absolute path to face icon
  ];

  security.polkit.enable = true;

  # Whether to enable the RealtimeKit system service, which hands out
  # realtime scheduling priority to user processes on demand.
  # For example, PulseAudio and PipeWire use this to acquire realtime priority.
  security.rtkit.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Dconf is a low-level configuration system used in the GNOME
  # desktop environment to manage user settings,
  # storing them as keys in a database.
  programs.dconf.enable = true;

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
    xserver.enable = true;

    displayManager = {
      # gdm.enable = true;
    };

    dbus = {
      enable = true;
      packages = [pkgs.gcr];
      # implementation = "broker";
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
    services.gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gnome.gvfs;
    };

    blueman.enable = true;

    udev.packages = with pkgs; [gnome-settings-daemon];
  };

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [
      "network.target"
      "sound.target"
    ];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  programs.kdeconnect.enable = true;
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  networking.firewall.allowedTCPPorts = [57621];
  networking.firewall.allowedUDPPorts = [5353];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.seahorse.enable = true; # enable the graphical frontend

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
