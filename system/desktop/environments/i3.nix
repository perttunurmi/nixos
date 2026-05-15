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

  services.displayManager.ly = {
    enable = true;
    x11Support = true;
  };

  services.xserver = {
    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        nautilus
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
        dex
        brightnessctl
        networkmanagerapplet
        copyq
        flameshot
        xdg-utils
      ];
    };
  };

  services.tumbler.enable = true;
}
