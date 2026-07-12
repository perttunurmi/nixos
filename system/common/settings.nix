{
  username,
  lib,
  ...
}:
{
  nix.settings = {
    trusted-users = [ username ];

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    builders-use-substitutes = true;

    auto-optimise-store = true;

  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "daily";
    options = lib.mkDefault "--delete-older-than 30d";
  };

  nix.optimise = {
    automatic = true;
    dates = lib.mkDefault [ "09:00" ];
  };
}
