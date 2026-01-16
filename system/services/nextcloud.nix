{
  pkgs,
  config,
  ...
}: let
  hostName = "nextcloud";
in {
  services.nextcloud = {
    enable = true;
    configureRedis = true;
    package = pkgs.nextcloud32;
    https = true;
    hostName = hostName;
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "pgsql";
    database.createLocally = true;
    settings.trusted_domains = [
      "nextcloud.nurmilab.xyz"
    ];
  };

  services.nginx.virtualHosts."${hostName}" = {
    listen = [
      {
        addr = "0.0.0.0";
        port = 8585;
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [8585];
}
