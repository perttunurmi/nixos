{...}: {
  services.nfs.server = {
    enable = true;
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
    exports = ''
      /mnt/ulkoinen/ 192.168.0.0/24(rw,sync,no_subtree_check)
    '';
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [111 2049 4000 4001 4002 20048];
    allowedUDPPorts = [111 2049 4000 4001 4002 20048];
  };
}
