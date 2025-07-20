{username, ...}: {
  imports = [
    ./file.nix
    ./packages.nix
    ./shell
    ./programs
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Perttu Nurmi";
    userEmail = "perttu.nurmi@gmail.com";
    extraConfig = {
      init.defaultBranch = "master";
    };

    signing = {
      format = "ssh";
      signByDefault = true;
      key = "/home/${username}/.ssh/id_ed25519.pub";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
