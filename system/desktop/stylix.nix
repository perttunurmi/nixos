{
  pkgs,
  username,
  lib,
  ...
}: {
  stylix.targets.plymouth.enable = false;

  stylix = {
    enable = true;
    #image = ../../users/perttu/wallpaper.jpg;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/default-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
    base16Scheme = ./kanagawa-dragon.yaml;

    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        terminal = 16;
        desktop = 11;
      };
    };
  };
}
