{
  lib,
  config,
  ...
}: {
  imports = [
    ./common/default.nix
  ];

  services.tailscale.enable = true;

  networking.firewall = {
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
    checkReversePath = "loose";
  };

  networking.nameservers = ["100.100.100.100" "8.8.8.8" "1.1.1.1"];
  networking.search = ["tail31079d.ts.net"];

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
