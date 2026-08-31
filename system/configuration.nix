{ lib, ... }:
{
  imports = [
    ./common/default.nix
    ./services/syncthing.nix
  ];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = lib.mkForce false;
      KbdInteractiveAuthentication = lib.mkForce false;
      AllowUsers = null;
      UseDns = true;
      PermitRootLogin = "prohibit-password";
    };
  };

  environment.enableAllTerminfo = true;
}
