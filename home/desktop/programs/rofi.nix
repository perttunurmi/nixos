{
  pkgs,
  config,
  lib,
  ...
}: {
  # stylix.targets.rofi.enable = false;

  programs.rofi = {
    enable = true;

    plugins = with pkgs; [
      rofi-emoji
      rofi-power-menu
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
