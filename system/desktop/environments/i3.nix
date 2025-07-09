{
  pkgs,
  lib,
  ...
}: {
  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
  services.displayManager.defaultSession = lib.mkDefault "xfce+i3";
  services.xserver = {
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        file-roller # gnome archive manager
        xsel # copy and paste to clipboard from the terminal
        redshift # automatic night light
        rofi # application launcher, the same as dmenu
        # dunst # notification daemon
        i3blocks # status bar
        # i3lock # default i3 screen locker
        # xautolock # lock screen after some time
        i3status # provide information to i3bar
        i3-gaps # i3 with gaps
        picom # transparency and shadows
        feh # set wallpaper
        acpi # battery information
        arandr # screen layout manager
        dex # autostart applications
        xbindkeys # bind keys to commands
        brightnessctl # control screen brightness
        xorg.xdpyinfo # get screen information
        sysstat # get system information
        networkmanagerapplet # networkmanager tray
        copyq # clipboard manager
        gpick # colorpicker
        flameshot # screenshot tool
      ];
    };
  };

  # thunar file manager(part of xfce) related options
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.tumbler.enable = true; # Thumbnail support for images
}
