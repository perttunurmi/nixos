{pkgs, ...}: {
  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer

    # images
    feh
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };

    obs-studio.enable = true;
  };

  services = {
    playerctld.enable = true;
  };
}
