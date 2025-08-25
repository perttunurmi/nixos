{...}: {
  xresources.properties = {
    # "Xcursor.size" = 16;
    # "Xft.dpi" = 100;
  };

  home.file = {
    xinitrc = {
      source = ./xinitrc;
      target = ".xinitrc";
    };
  };
}
