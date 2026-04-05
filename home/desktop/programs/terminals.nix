{lib, ...}: let
  iosevka = "Iosevka NerdFont";
  jetbrains = "JetBrainsMono Nerd Font";
  firacode = "FiraCode Nerd Font";
  ubuntu = "UbuntuMono Nerd Font";
  font = jetbrains;
in {
  programs = {
    alacritty = lib.mkForce {
      enable = true;
      settings = {
        window.opacity = 0.90;
        window.dynamic_padding = true;
        window.padding = {
          y = 0;
        };

        font = lib.mkDefault {
          normal.family = font;
          bold.family = font;
          italic.family = font;
          size = 16;
        };
      };
    };
  };
}
