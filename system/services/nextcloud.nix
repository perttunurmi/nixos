{
  pkgs,
  config,
  ...
}: let
  hostName = "nextcloud";
in {
  # Nextcloud requires a password file to be created manually before the service can start.
  # The admin password must be stored in /etc/nextcloud-admin-pass with restrictive permissions.
  #
  # To set up the password file securely:
  #   read -s -p "Enter admin password: " NEXTCLOUD_PASS && echo
  #   echo "$NEXTCLOUD_PASS" | sudo tee /etc/nextcloud-admin-pass > /dev/null
  #   unset NEXTCLOUD_PASS
  #   sudo chmod 600 /etc/nextcloud-admin-pass
  #   sudo chown nextcloud:nextcloud /etc/nextcloud-admin-pass
  #
  # Note: Consider migrating to agenix for proper secrets management in the future.
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

    extraAppsEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };
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
