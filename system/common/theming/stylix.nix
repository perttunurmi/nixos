{
  pkgs,
  lib,
  ...
}:
{
  stylix = {
    enable = lib.mkDefault true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
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
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 11;
        terminal = 12;
        desktop = 11;
      };
    };

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 28;
    };

    targets = {
      plymouth.enable = true;
      gtk.enable = true;
      qt.enable = true;
      console.enable = false;
    };
  };
}
