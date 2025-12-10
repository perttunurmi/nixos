{pkgs, ...}: {
  imports = [
    ./hyprland/hyprland.nix
    ./xorg/xorg.nix
    ./browser.nix
    ./media.nix
    ./rofi.nix
    ./terminals.nix
    ./xdg.nix
  ];
  stylix.targets.xresources.enable = true;
  stylix.targets.gtk = {
    enable = true;
    extraCss = ''
      * { border-radius: 0; }
    '';
    flatpakSupport.enable = true;
  };

  home.sessionVariables = {
    TERMINAL = "GHOSTTY";
  };

  home.sessionPath = [ "/snap/bin" ];

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
}
