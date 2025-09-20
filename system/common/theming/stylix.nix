{
  pkgs,
  username,
  lib,
  config,
  ...
}: {
  stylix = {
    enable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/default-dark.yaml";
    base16Scheme = ./apprentice.yaml;
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

    targets = {
      plymouth.enable = false;
      gtk.enable = true;
      qt.enable = true;
    };

    iconTheme = {
      dark = pkgs.papirus-icon-theme;
    };
  };
}
