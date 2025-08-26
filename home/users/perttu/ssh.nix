{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
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
    };
  };
}
