{pkgs, ...}: {
  imports = [
    ./hyprland/hyprland.nix
    ./programs/browser.nix
    ./programs/rofi.nix
    ./programs/terminals.nix
    ./xorg/xorg.nix
    ./media.nix
    ./xdg.nix
  ];
  home.sessionVariables = {
    TERMINAL = "GHOSTTY";
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
    ghostscript
    tectonic
    mermaid-cli
    texlivePackages.pdftex
    imagemagickBig
  ];
}
