{lib, ...}: {
  virtualisation.docker = {
    enable = lib.mkDefault true;
    enableOnBoot = lib.mkDefault false;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
