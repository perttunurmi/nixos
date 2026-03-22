{pkgs, ...}: {
  config.services.postgresql = {
    enable = true;

    enableTCPIP = true;
    port = 5432;

    ensureDatabases = ["mydatabase"];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };
}
