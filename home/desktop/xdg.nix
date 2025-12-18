{
  config,
  wsl,
  lib,
  ...
}: let
in {
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";
    configHome = config.home.homeDirectory + "/.config";
    dataHome = config.home.homeDirectory + "/.local/share";
    
    mimeApps = {
      enable = false;
    };

    userDirs = {
      enable = true;
      createDirectories = false;
      templates = "${config.home.homeDirectory}/media/templates";
      pictures = "${config.home.homeDirectory}/media/pictures";
      videos = "${config.home.homeDirectory}/media/videos";
      music = "${config.home.homeDirectory}/media/music";
      download = "${config.home.homeDirectory}/downloads";
      documents = "${config.home.homeDirectory}/documents";
      publicShare = "${config.home.homeDirectory}/public";
      desktop = "${config.home.homeDirectory}/desktop";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
      };
    };
  };
}
