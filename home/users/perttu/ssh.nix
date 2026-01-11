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

      "fujitsu" = {
        host = "Fujitsu";
        hostname = "alavus.nurmilab.xyz";
        user = "root";
        port = 22;
      };

      "yoga" = {
        host = "Yoga";
        hostname = "100.117.29.124";
        user = "perttu";
        port = 22;
      };

      "wsl" = {
        host = "nixos";
        hostname = "100.116.84.41";
        user = "perttu";
        port = 2222;
      };

      "windows" = {
        host = "windows";
        hostname = "100.100.237.1";
        user = "perttu";
        port = 22;
      };
    };
  };
}
