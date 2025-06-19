{ pkgs, config, ... }: {
  imports = [
    ../../home/core.nix

    ../../home/shell
    ../../home/programs
    ../../home/rclone
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Perttu Nurmi";
    userEmail = "perttu.nurmi@gmail.com";
    extraConfig = {
      init.defaultBranch = "master";
    };
  };

  home.packages = with pkgs; [
   gh

   lua-language-server
   zig
   clang
   nodejs
   go
   jdt-language-server
   vscode-js-debug
   rust-analyzer
   texliveFull
   vscode.fhs
   lombok
   maven
   lua
   python3Full
  ];

}
