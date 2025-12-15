{
  lib,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = lib.mkDefault true;

    xkb = lib.mkDefault {
      layout = "us";
      variant = "altgr-intl";
    };
  };

  environment.systemPackages = with pkgs; [
        xorg.libXft
        xorg.libXinerama
        xorg.libX11
        xsel
        xbindkeys
        xorg.xdpyinfo
        arandr
        xautolock
  ];
}
