{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    clang-tools
    xorg.libXft
    xorg.libXinerama
    xorg.libX11

    nitrogen
    file-roller # gnome archive manager
    qimgv
    cheese
    feh
    arandr
    udiskie
    networkmanagerapplet # networkmanager tray
    acpi
    sysstat
    networkmanagerapplet
    copyq
    brightnessctl
    xsel # copy and paste to clipboard from the terminal
    redshift # automatic night light
    rofi # application launcher, the same as dmenu
    # dunst # notification daemon
    # xautolock # lock screen after some time
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

  # thunar file manager(part of xfce) related options
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.tumbler.enable = true; # Thumbnail support for images

  programs.slock.enable = true;
  programs.xss-lock.enable = true;
  programs.xss-lock.lockerCommand = "${pkgs.slock}/bin/slock";
  services = {
    displayManager.ly.enable = true;
    xserver.enable = true;
    xserver.windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        pname = "dwm";
        src = ./config/dwm;
      };
    };
  };
}
