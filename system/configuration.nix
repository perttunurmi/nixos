{lib, ...}: {
  imports = [
    ./common/default.nix
  ];

  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "prohibit-password";
    };
    openFirewall = true;
  };
}
