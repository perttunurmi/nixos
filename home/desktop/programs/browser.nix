{
  username,
  inputs,
  pkgs,
  ...
}: {
  programs = {
    chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = ["--enable-features=TouchpadOverscrollHistoryNavigation"];
      extensions = [
        # {id = "";}  // extension id, query from chrome web store
      ];
    };

    # firefox = {
    #   enable = true;
    # };
  };

  home.packages = with pkgs; [
    # inputs.zen-browser.packages.x86_64-linux.default
    google-chrome
  ];
}
