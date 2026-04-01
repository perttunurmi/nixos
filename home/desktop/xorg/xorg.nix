_: {
  xresources.properties = {
    "Xft.dpi" = 100;
  };

  home.file = {
    xinitrc = {
      source = ./xinitrc;
      target = ".xinitrc";
    };
  };
}
