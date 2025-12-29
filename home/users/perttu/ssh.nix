{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
      };

      "github" = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/id_ed25519"
        ];
      };

      "Fujitsu" = {
        host = "Fujitsu";
        hostname = "alavus.nurmilab.xyz";
        user = "root";
        port = 22;
      };

      "Yoga" = {
        host = "Yoga";
        hostname = "pertz.tplinkdns.com";
        user = "perttu";
        port = 22;
      };
    };
  };
}
