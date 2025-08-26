{...}: {
  imports = [
    ./hyprland/hyprland.nix
    ./xorg/xorg.nix
    ./browser.nix
    ./media.nix
    ./rofi.nix
    ./terminals.nix
    ./xdg.nix
  ];

  home.sessionVariables = {
    TERMINAL = "ALACRITTY";
  };
}
