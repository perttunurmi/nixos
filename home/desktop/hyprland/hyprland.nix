{...}: {
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 6;
      actions = true;
      icons = true;
      ignore-timeout = true;
      markup = true;
    };
  };
  programs.bat.enable = true;
}
