# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "T480s"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.defaultGateway = "192.168.5.201";

  # Nvidia GPU
  # services.xserver.videoDrivers = ["nvidia"];
  # hardware.opengl.enable = true;
  # hardware.nvidia = {
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  #   modesetting.enable = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  # services.displayManager.defaultSession = "none+i3";
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      cinnamon.enable = true;
    };

    displayManager = {
      lightdm.enable = false;
      gdm.enable = true;
    };

    libinput.enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi # application launcher, the same as dmenu
        dunst # notification daemon
        i3blocks # status bar
        i3lock # default i3 screen locker
        xautolock # lock screen after some time
        i3status # provide information to i3bar
        i3-gaps # i3 with gaps
        picom # transparency and shadows
        feh # set wallpaper
        acpi # battery information
        arandr # screen layout manager
        dex # autostart applications
        xbindkeys # bind keys to commands
        xorg.xbacklight # control screen brightness
        xorg.xdpyinfo # get screen information
        sysstat # get system information

        # move
        google-chrome
        alacritty
        vscode.fhs
        vscode
        chromium
        firefox
        lua-language-server
        nodejs
        docker
        clang
        cargo
        unzip
        wget
        vim
        zig
        gcc
        go
      ];
    };

    xkb.layout = "us";
    xkb.variant = "altgr-intl";
  };

  # thunar file manager(part of xfce) related options
  # programs.thunar.plugins = with pkgs.xfce; [
  #   thunar-archive-plugin
  #   thunar-volman
  # ];
  # services.gvfs.enable = true; # Mount, trash, and other functionalities
  # services.tumbler.enable = true; # Thumbnail support for images
}
