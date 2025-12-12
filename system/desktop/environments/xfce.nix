{
  lib,
  config,
  pkgs,
  callPackage,
  ...
}: {
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = false;
        enableXfwm = true;
      };
    };
  };
  services.displayManager.defaultSession = lib.mkDefault "xfce";
}
