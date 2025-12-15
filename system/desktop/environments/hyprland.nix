{
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };

  services.displayManager.gdm.enable = true;

  # services.displayManager.defaultSession = "hyprland";
  services.avahi.enable = true;

  environment.systemPackages = with pkgs; [
    file-roller
    avahi
    qimgv
    cheese
    kdePackages.kdenlive
    hypridle
    xdg-desktop-portal-hyprland
    feh
    acpi
    sysstat
    networkmanagerapplet
    copyq
    brightnessctl
    slurp
    hyprsunset
    grim


    waybar
    hyprcursor
    swww
    wl-clipboard
    libnotify
    mako
    hyprls
    udiskie
    networkmanagerapplet
    hyprland-qtutils
    hyprpolkitagent
    hyprsysteminfo
    wlsunset
    hyprlock
    hyprpicker
    hyprland-qt-support
  ];

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.tumbler.enable = true; # Thumbnail support for images

  # environment.sessionVariables = lib.mkAfter {
  #   NIXOS_OZONE_WL = "1";
  #   QT_QPA_PLATFORM = "wayland";
  #   SDL_VIDEODRIVER = "wayland";
  #   XDG_SESSION_TYPE = "wayland";
  # };
}
