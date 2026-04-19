{
  pkgs,
  lib,
  ...
}:
{
  environment.pathsToLink = [ "/libexec" ];
  services.displayManager.defaultSession = lib.mkDefault "none+i3";

  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # services.displayManager.ly = {
  #   enable = true;
  #   x11Support = true;
  # };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];

  services.xserver = {
    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        nautilus
        snixembed
        kitty
        bc
        libgnome-keyring
        xss-lock
        libsecret
        qimgv
        udiskie
        file-roller
        redshift
        rofi
        dunst
        i3blocks
        i3lock-fancy-rapid
        i3status
        i3
        picom
        feh
        acpi
        dex
        brightnessctl
        sysstat
        networkmanagerapplet
        copyq
        flameshot
        xdg-utils
      ];
    };
  };

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.tumbler.enable = true;
}
