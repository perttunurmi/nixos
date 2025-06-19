{ pkgs, config, ... }: {

  programs.bash.enable = true;
  xdg.enable = true;

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
