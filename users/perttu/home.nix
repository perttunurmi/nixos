{ pkgs, ... }: {
  imports = [
    ../../home/core.nix

    ../../home/shell
  ];

  programs.git = {
    userName = "Perttu Nurmi";
    userEmail = "perttu.nurmi@gmail.com";
  };
}
