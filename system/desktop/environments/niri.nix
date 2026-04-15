{
  pkgs,
  lib,
  ...
}:
{
  imports = [
  ];

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  environment = {
    systemPackages = with pkgs; [
      nautilus
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

    sessionVariables = lib.mkAfter {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };

  services.tumbler.enable = true; # Thumbnail support for images
}
