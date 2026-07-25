{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "Perttu Nurmi";
        email = "perttu.nurmi" + "@" + "gmail.com";
      };
      init.defaultBranch = "main";
    };

    signing = {
      format = "openpgp";
      signByDefault = true;
      key = "perttu" + "." + "nurmi" + "@" + "gmail.com";
    };

    ignores = [
      ".cache"
      "compile_commands.json"
      "*.gc??"
      "vgcore.*"
      "venv"
      ".venv"
      "*~"
      ".DS_Store"
      ".direnv"
      "result"
      ".idea"
      ".zed"
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
