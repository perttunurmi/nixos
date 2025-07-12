{config, ...}: {
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = false;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[ ](bold green)";
        error_symbol = "[󰞇 ](bold red)";
      };
    };
  };
}
