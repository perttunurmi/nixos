{
  pkgs,
  lib,
  ...
}: {
  environment.pathsToLink = ["/libexec"];
  services.displayManager.defaultSession = lib.mkDefault "none+i3";
  services.displayManager.ly.enable = true;
  programs.slock.enable = true;

  services.xserver = {
    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        xorg.libXft
        xorg.libXinerama
        xorg.libX11

        gcc
        clang-tools
        gnumake

        qimgv
        udiskie
        autotiling
        file-roller
        xsel
        redshift
        rofi
        dunst
        i3blocks
        i3lock
        xautolock
        i3status
        i3
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
        nitrogen
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
