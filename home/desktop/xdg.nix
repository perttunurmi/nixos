{
  config,
  wsl,
  lib,
  ...
}: let
  homeD = config.home.homeDirectory;
in {
  home.preferXdgDirectories = true;

  xdg = {
    enable = true;

    cacheHome = homeD + "/.local/cache";
    configHome = homeD + "/.config";
    dataHome = homeD + "/.local/share";
    stateHome = homeD + "/.local/state";

    mimeApps = {
      enable = false;
    };

    userDirs = {
      enable = true;
      createDirectories = false;
      templates = "${homeD}/media/templates";
      pictures = "${homeD}/media/pictures";
      videos = "${homeD}/media/videos";
      music = "${homeD}/media/music";
      download = "${homeD}/media/downloads";
      documents = "${homeD}/media/documents";
      publicShare = "${homeD}/media/public";
      desktop = "${homeD}/desktop";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
      };
    };
  };
}
