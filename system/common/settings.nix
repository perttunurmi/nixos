{
  username,
  lib,
  ...
}: {
  # customise /etc/nix/nix.conf declaratively via `nix.settings`
  nix.settings = {
    # given the users in this list the right to specify additional substituters via:
    #    1. `nixConfig.substituers` in `flake.nix`
    #    2. command line args `--options substituers http://xxx`
    trusted-users = [username];

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    auto-optimise-store = false;

    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
    ];

    builders-use-substitutes = true;
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nix.optimise = {
    automatic = true;
    dates = lib.mkDefault ["09:00"];
  };
}
