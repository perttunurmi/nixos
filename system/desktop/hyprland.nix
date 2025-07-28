{
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  programs.hyprland = {
    enable = true; # enable Hyprland
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  services.displayManager.defaultSession = "hyprland-uwsm";
  services.avahi.enable = true;

  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors = {
    hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };

  environment.systemPackages = with pkgs; [
    (flameshot.override {enableWlrSupport = true;})
    file-roller # gnome archive manager
    avahi
    uwsm
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
    dunst
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
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
