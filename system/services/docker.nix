{lib, ...}: {
  virtualisation.docker = {
    enable = lib.mkDefault true;
    enableOnBoot = lib.mkDefault true;

    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };

    daemon.settings = {
      data-root = "/home/docker/data";
    };
  };
}
