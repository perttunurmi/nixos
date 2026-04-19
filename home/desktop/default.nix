{ pkgs, ... }:
{
  imports = [
    ./programs/browser.nix
    ./programs/rofi.nix
    ./programs/terminals.nix
    ./programs/sioyek.nix
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
    gtk4.theme = null;
    enable = true;
    iconTheme = {
      name = "MoreWaita"; # Or "Papirus", "Papirus-Light"
      package = pkgs.morewaita-icon-theme;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        icon-theme = "MoreWaita";
      };
    };
  };

  home.packages = with pkgs; [

  ];
}
