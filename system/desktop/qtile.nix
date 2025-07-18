{ pkgs, ... }:{
  environment.systemPackages = [
    (pkgs.python3.withPackages (ps: with ps; [
      qtile
    ]))
  ];
  services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages = python3Packages: with python3Packages; [
    qtile-extras
  ];
};
}
