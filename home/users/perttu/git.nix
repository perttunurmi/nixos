{username, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "Perttu Nurmi";
        email = "perttu.nurmi" + "@" + "gmail.com";
      };
      init.defaultBranch = "master";
    };

    signing = {
      format = "openpgp";
      signByDefault = true;
      # key = "/home/${username}/.ssh/id_ed25519.pub";
      key = "perttu" + "." + "nurmi" + "@" + "gmail.com";
      # gpgsign = "true";
    };

    ignores = [
      ".cache"
      "compile_commands.json"
      "*.gc??"
      "vgcore.*"
      "venv"
      "*~"
      ".DS_Store"
      ".direnv"
      ".envrc"
      "result"
      ".idea"
      ".vscode"
      ".vs"
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
