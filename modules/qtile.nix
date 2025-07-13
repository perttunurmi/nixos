{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver.windowManager.qtile.enable = true;
  services.xserver.displayManager.sessionPackages = [pkgs.qtile-unwrapped];
}
