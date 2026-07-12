{
  pkgs,
  lib,
  username,
  ...
}:
{
  environment.pathsToLink = [ "/libexec" ];
  services.displayManager.defaultSession = lib.mkDefault "none+i3";

  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;

  security.pam.services.i3lock.enable = true;

  services.xserver = {

    displayManager.lightdm = {
      enable = true;
      greeters.mini = {
        enable = true;
        user = "${username}";
      };
    };

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
        brightnessctl
        i3
        picom
        feh
        dex
        networkmanagerapplet
        copyq
        flameshot
        xdg-utils
      ];
    };
  };

  services.tumbler.enable = true;
}
