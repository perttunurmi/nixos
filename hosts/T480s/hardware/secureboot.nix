{
  pkgs,
  lib,
  ...
}: let
in {
  environment.systemPackages = with pkgs; [
    sbctl
    niv
  ];
}
