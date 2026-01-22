{pkgs, ...}: {
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
    tiled
    ghostty
    zed-editor
    gimp3-with-plugins
    ghostscript
    tectonic
    mermaid-cli
    texlivePackages.pdftex
    imagemagickBig
  ];
}
