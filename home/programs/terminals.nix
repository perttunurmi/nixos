{lib, ...}: let
  iosevka = "Iosevka NerdFont";
  jetbrains = "JetBrainsMono Nerd Font";
  font = jetbrains;
in {
  programs = {
    alacritty = lib.mkDefault {
      enable = true;
      settings = {
        #       window.opacity = 0.95;
        #       window.dynamic_padding = true;
        #       window.padding = {
        #         x = 5;
        #         y = 5;
        #       };
        #       scrolling.history = 10000;
        #
        font = lib.mkForce {
          normal.family = font;
          bold.family = font;
          italic.family = font;
          size = 16;
        };
      };
    };
  };
}
