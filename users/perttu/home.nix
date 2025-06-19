{ pkgs, ... }: {
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

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
   lua-language-server
   zig
   just
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
