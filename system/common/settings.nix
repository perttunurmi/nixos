{
  username,
  lib,
  ...
}: {
  nix.settings = {
    trusted-users = [username];

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    auto-optimise-store = false;

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "perttunurmi.cachix.org-1:Orru9XifzS0PwnnSXa1EWrSc46YNEWJuM5Nh+pJYdyI="
    ];

    builders-use-substitutes = true;
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 90d";
  };

  nix.optimise = {
    automatic = true;
    dates = lib.mkDefault ["09:00"];
  };
}
