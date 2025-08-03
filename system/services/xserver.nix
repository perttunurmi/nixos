{lib, ...}: {
  services.xserver = {
    enable = lib.mkDefault true;

    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };
}
