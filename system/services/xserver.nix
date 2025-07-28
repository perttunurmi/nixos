{lib, ...}: {
  # services.displayManager.gdm.enable = lib.mkDefault true;

  services.xserver = {
    enable = lib.mkDefault true;

    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };
}
