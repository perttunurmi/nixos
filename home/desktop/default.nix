{ pkgs, ... }:
{
  imports = [
    ./programs/browser.nix
    ./programs/rofi.nix
    ./programs/terminals.nix
    ./xorg/xorg.nix
    ./media.nix
    ./xdg.nix
  ];

  home.sessionVariables = {
  };

  stylix = {
    enable = true;
    targets.neovim.enable = false;
    targets.xresources.enable = true;
    targets.gtk = {
      enable = true;
      extraCss = ''
        * { border-radius: 0; }
      '';
      flatpakSupport.enable = true;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark"; # Or "Papirus", "Papirus-Light"
      package = pkgs.papirus-icon-theme;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        icon-theme = "Papirus-Dark";
      };
    };
  };

  home.packages = with pkgs; [
    ghostty
    imagemagick
  ];
}
