{
  pkgs,
  config,
  lib,
  ...
}: {
  # stylix.targets.rofi.enable = false;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    plugins = with pkgs; [
      rofi-emoji-wayland
      rofi-calc
    ];

    modes = [
      "drun"
      "window"
      "emoji"
      "calc"
    ];

    font = lib.mkForce "${pkgs.nerd-fonts.fira-mono} 14";

  };
}
