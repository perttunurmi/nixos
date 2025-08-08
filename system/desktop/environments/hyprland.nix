{
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  programs.hyprland = {
    enable = true; # enable Hyprland
    withUWSM = false; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.displayManager.gdm.enable = true;

  services.displayManager.defaultSession = "hyprland";
  services.avahi.enable = true;

  environment.systemPackages = with pkgs; [
    (flameshot.override {enableWlrSupport = true;})
    file-roller # gnome archive manager
    avahi
    hypridle
    xdg-desktop-portal-hyprland
    clipse
    feh
    acpi
    sysstat
    networkmanagerapplet
    copyq
    brightnessctl
    arandr
    slurp
    hyprsunset
    grim
    gimp3-with-plugins
    kitty
    waybar
    hyprcursor
    ghostty
    swww
    wl-clipboard
    libnotify
    mako
    hyprls
    udiskie
    networkmanagerapplet # networkmanager tray
    hyprland-qtutils
    rofi-wayland
    hyprpolkitagent
    hyprsysteminfo
    wlsunset
    hyprlock
    hyprpicker
    hyprland-qt-support
  ];

  # thunar file manager(part of xfce) related options
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.tumbler.enable = true; # Thumbnail support for images

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
