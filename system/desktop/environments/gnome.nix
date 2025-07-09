{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-text-editor
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-connections
    gnome-photos
    gnome-terminal
    gnome-tour
    gnome-weather
    gnome-calendar
    gnome-contacts
    gnome-console
    gnome-color-manager
    nautilus # file manager
    hitori # sudoku game
    evince
    iagno # go game
    tali # poker game
    totem # video player
  ];

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme-legacy
    adwaita-icon-theme
    adwaita-fonts
    adwaita-qt6
    adwaita-qt
    gdm-settings
  ];
}
