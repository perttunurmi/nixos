{
  pkgs,
  lib,
  ...
}: {
  programs.hyprland.enable = true; # enable Hyprland
  services.displayManager.defaultSession = lib.mkForce "hyprland";

  environment.systemPackages = with pkgs; [
    waybar
    hyprcursor
    ghostty
    swww
  ];

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
