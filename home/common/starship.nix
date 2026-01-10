{
  config,
  wsl,
  ...
}: {
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = !wsl;
    settings = {
      character = {
        success_symbol = "[を](bold green)";
        error_symbol = "[ㄪ](bold red)";
      };

      git_status = {
        deleted = "✗";
        modified = "✶";
        staged = "✓";
        stashed = "≡";
      };

      nix_shell = {
        symbol = " ";
        heuristic = true;
      };

      kotlin = {
        format = "";
      };

      scala = {
        format = "";
      };
    };
  };
}
