{lib, ...}: {
  services.xserver = {
    enable = lib.mkDefault true;

    xkb = lib.mkDefault {
      layout = "us";
      variant = "altgr-intl";
    };
  };
}
