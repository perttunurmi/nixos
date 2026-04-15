{
  username,
  wsl,
  server,
  desktop,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./users/${username}/default.nix
    ./common/default.nix
  ]
  ++ (lib.optionals desktop [ ./desktop/default.nix ]);

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

  home.sessionPath = [ "/snap/bin" ];

  programs.home-manager.enable = true;
}
