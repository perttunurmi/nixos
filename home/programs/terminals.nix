{...}: let
  iosevka = "Iosevka NerdFont";
  _jetbrains = "JetBrainsMono Nerd Font";
  font = iosevka;
in {
  programs = {
    alacritty = {
      enable = false;
      #     settings = {
      #       window.opacity = 0.95;
      #       window.dynamic_padding = true;
      #       window.padding = {
      #         x = 5;
      #         y = 5;
      #       };
      #       scrolling.history = 10000;
      #
      #       font = {
      #         normal.family = font;
      #         bold.family = font;
      #         italic.family = font;
      #         size = 12;
      #       };
      #     };
    };
  };
}
