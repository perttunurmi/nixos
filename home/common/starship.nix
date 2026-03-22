{
  config,
  wsl,
  ...
}: {
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = !wsl;
    settings = {
      scan_timeout = 50;
      # character = {
      #   success_symbol = "[を](bold green)";
      #   error_symbol = "[ㄪ](bold red)";
      # };

      format = "$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character";

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
