{pkgs, ...}: {
  # https://wiki.nixos.org/wiki/Immich
  services.immich = {
    enable = true;
    port = 2283;
    openFirewall = true;
    host = "0.0.0.0";
    # sudo -u immich mkdir -p /var/lib/immich/{upload,library,thumbs,encoded-video,profile,backups}
    # sudo -u immich touch /var/lib/immich/{upload,library,thumbs,encoded-video,profile,backups}/.immich
    mediaLocation = "/var/lib/immich";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
    ];
  };

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Optionally, set the environment variable

  users.users.immich.extraGroups = ["video" "render"];
}
