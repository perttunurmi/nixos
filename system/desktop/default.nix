{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../system/configuration.nix

    ../services/keyd.nix
    ./fonts.nix
    ./gamemode.nix
    ./i3.nix
    ./qtile.nix
    ./hyprland.nix

    ../services/xserver.nix
    ../services/keyd.nix
    ../services/ssh.nix
    ../services/docker.nix
  ];

  programs.java.enable = true;

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
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  users.users.${username}.packages = with pkgs; [
    gnome-software
    flatpak
    preload
    obsidian
    vscode.fhs
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions;
        [
          bbenoist.nix
          ms-python.python
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-ssh
          ms-toolsai.jupyter
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
    chromium
    discord
    firefox
    brave
    android-tools
    scrcpy
  ];

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

  services.power-profiles-daemon = {
    enable = true;
  };

  services = {
    xserver.enable = true;

    displayManager = {
      # lightdm.enable = true;
      gdm.enable = true;
    };

    dbus.enable = true;
    dbus.packages = [pkgs.gcr];

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
    gvfs.enable = true; # Mount, trash, and other functionalities

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

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.seahorse.enable = true; # enable the graphical frontend

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
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
  };
}
