{
  config,
  lib,
  pkgs,
  ...
}: {
  services.samba = {
    package = pkgs.samba4Full;
    enable = true;
    usershares.enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.1. 192.168.0. 127.0.0.1 localhost 100.64.";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };

      homes = {
        comment = "Home Directories";
        browseable = "yes";
        "read only" = "no";
        "create mask" = "0700";
        "directory mask" = "0700";
        "valid users" = "%S";
      };

      "public" = {
        "path" = "/mnt/ulkoinen/";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    nssmdns4 = true;

    enable = true;
    openFirewall = true;
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
}
