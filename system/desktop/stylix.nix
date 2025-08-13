{pkgs, ...}: {
  stylix.targets.plymouth.enable = false;
  stylix = {
    enable = true;
    #image = ../../users/perttu/wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/default-dark.yaml";
    polarity = "dark";
  };
}
