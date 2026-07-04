{
  lib,
  pkgs,
  ...
}:
{
  services.xserver = {
    enable = lib.mkDefault true;

    xkb = lib.mkDefault {
      layout = "us";
      variant = "altgr-intl";
    };
  };

  environment.systemPackages = with pkgs; [
    xsel
    arandr
    xdo
  ];
}
