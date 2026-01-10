{
  username,
  wsl,
  server,
  desktop,
  pkgs,
  lib,
  config,
  ...
}: {
  imports =
    [
      ./users/${username}/default.nix
      ./common/default.nix
    ]
    ++ (lib.optionals desktop [./desktop/default.nix]);

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

  home.sessionPath = ["/snap/bin"];

  stylix = {
    targets.xresources.enable = true;
    targets.gtk = {
      enable = true;
      extraCss = ''
        * { border-radius: 0; }
      '';
      flatpakSupport.enable = true;
    };
  };

  programs.home-manager.enable = true;
}
