{ pkgs, ... }: {
  imports = [
    ../../home/core.nix

    ../../home/shell
    ../../home/programs
    ../../home/rclone
  ];

  programs.git = {
    userName = "Perttu Nurmi";
    userEmail = "perttu.nurmi@gmail.com";
  };
}
