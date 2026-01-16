{
  pkgs,
  lib,
  ...
}: {
  environment.pathsToLink = ["/libexec"];
  services.displayManager.defaultSession = lib.mkDefault "none+i3";

  programs.dconf.enable = true;

  services.displayManager.ly.enable = true;

  services.xserver = {
    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        qimgv
        udiskie
        autotiling
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
        gpick
        flameshot
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
