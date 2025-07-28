{pkgs, ...}: {
  home.packages = with pkgs; [
    adwaita-icon-theme
    dconf
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;

    # theme = {
    #   package = pkgs.material-black-colors;
    #   name = "Material-Black-Colors-Desktop";
    # };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    #
    # font = {
    #   name = "Sans"; size = 11;
    # };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.libsForQt5.breeze-qt5;
    };
  };
}
