{...}: {
  services.mako = {
    enable = true;
    settings = {
      # default-timeout = 6;
      # ignore-timeout = true;
      actions = true;
      icons = true;
      markup = true;
    };
  };
  programs.bat.enable = true;
}
