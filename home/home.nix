{
  username,
  desktop,
  lib,
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

  home.sessionPath = [ ];

  programs.home-manager.enable = true;
}
