{...}: {
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 125;
  };

  home.file = {
    xinitrc = {
      source = ./xinitrc;
      target = ".xinitrc";
    };
  };

  home.file = {
    autostart = {
      source = ./autostart.sh;
      target = ".local/share/dwm/autostart.sh";
      executable = true;
    };
  };
}
