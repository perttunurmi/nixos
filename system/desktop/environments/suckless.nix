{
  lib,
  pkgs,
  dwm-config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    xorg.libXft
    xorg.libXinerama
    xorg.libX11
    fontconfig
    freetype
    harfbuzz
    gcc
    gnumake

    nitrogen
    file-roller
    qimgv
    cheese
    feh
    arandr
    udiskie
    networkmanagerapplet
    acpi
    sysstat
    networkmanagerapplet
    copyq
    brightnessctl
    xsel
    redshift
    rofi
    dunst
    xautolock
    picom
    feh
    acpi
    arandr
    dex
    xbindkeys
    brightnessctl
    xorg.xdpyinfo
    sysstat
    networkmanagerapplet
    copyq
    gpick
    flameshot
  ];

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.tumbler.enable = true;

  programs.slock.enable = true;
  services = {
    # displayManager.ly.enable = lib.mkDefault true;
    xserver.windowManager.dwm = {
      enable = false;
      package = pkgs.dwm.overrideAttrs {
        pname = "dwm";
        src = dwm-config;
      };
    };
  };
}
