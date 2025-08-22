{
  username,
  wsl,
  server,
  pkgs,
  lib,
  config,
  ...
}: {
  imports =
    (
      if !server
      then
        if !wsl
        then [
          ./programs
        ]
        else []
      else []
    )
    ++ [
      ./packages.nix
      ./shell
    ];

  stylix.targets.neovim.enable = false;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Perttu Nurmi";
    userEmail = "perttu.nurmi" + "@" + "gmail.com";
    extraConfig = {
      init.defaultBranch = "master";
    };

    signing = {
      format = "ssh";
      signByDefault = true;
      key = "/home/${username}/.ssh/id_ed25519.pub";
    };

    ignores = [
      # C commons
      ".cache"
      "compile_commands.json"
      "*.gc??"
      "vgcore.*"
      # Python
      "venv"
      # Locked Files
      "*~"
      # Mac folder
      ".DS_Store"
      # Direnv
      ".direnv"
      ".envrc"
      # Nix buid
      "result"
      # IDE Folders
      ".idea"
      ".vscode"
      ".vs"
      # Dotenv
      ".env"
    ];
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
