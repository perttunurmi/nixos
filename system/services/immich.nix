{pkgs, ...}: {
  services.immich.enable = true;
  services.immich.port = 2283;
  services.immich.openFirewall = true;

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
