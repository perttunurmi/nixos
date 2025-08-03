{
  config,
  wsl,
  lib,
  ...
}: let
  browser = ["zen-browser.desktop"];

  # XDG MIME types
  associations = {
    "image/jpeg" = "feh.desktop";
    "image/png" = "feh.desktop";

    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/chrome" = ["chromium-browser.desktop"];
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.desktop"];
    "image/*" = ["feh.desktop"];
    "application/json" = browser;
    "application/pdf" = ["org.pwmt.zathura.desktop.desktop"];
    "x-scheme-handler/discord" = ["discord.desktop"];
    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
  };
in {
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    # mimeApps = {
    #   enable = true;
    #   defaultApplications = associations;
    # };

    userDirs = {
      enable = true;
      # createDirectories = if !wsl then true else false;
      createDirectories = lib.mkIf (!wsl) true;
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
