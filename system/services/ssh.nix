{lib, ...}: {
  # Enable the OpenSSH daemon.
  # https://wiki.nixos.org/wiki/SSH
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
    openFirewall = true;
  };
}
