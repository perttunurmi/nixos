{ pkgs, config, ... }: {

  imports = [
    ../../home/core.nix

    ../../home/shell
    ../../home/programs
    ../../home/rclone
  ];

  xdg.enable = true;

  programs.git = {
    userName = "Perttu Nurmi";
    userEmail = "perttu.nurmi@gmail.com";
  };
}
