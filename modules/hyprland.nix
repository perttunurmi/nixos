{pkgs, ...}: {
  programs.hyprland.enable = true; # enable Hyprland

  environment.systemPackages = with pkgs; [
    hyprcursor
    ghostty
    swww
  ];

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
