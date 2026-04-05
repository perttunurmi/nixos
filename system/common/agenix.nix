{
  pkgs,
  lib,
  config,
  agenix,
  mysecrets,
  username,
  ...
}: let
  hostName = config.networking.hostName;
  commonSecretFile = "${mysecrets}/nixos/common/passwords.age";
  hostSecretFile = "${mysecrets}/nixos/hosts/${hostName}/passwords.age";
in {
  environment.systemPackages = [
    agenix.packages.${pkgs.system}.default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/home/${username}/.ssh/id_ed25519"
  ];

  age.secrets = lib.mkMerge [
    (lib.mkIf (builtins.pathExists commonSecretFile) {
      common-passwords = {
        file = commonSecretFile;
        owner = username;
        group = "users";
        mode = "0400";
      };
    })
    (lib.mkIf (builtins.pathExists hostSecretFile) {
      host-passwords = {
        file = hostSecretFile;
        owner = username;
        group = "users";
        mode = "0400";
      };
    })
  ];
}
