{
  lib,
  pkgs,
  ...
}:
{
  services.xserver = {
    enable = lib.mkDefault true;
    displayManager.startx.enable = lib.mkDefault true;
    excludePackages = lib.mkDefault [ pkgs.xterm ];

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
