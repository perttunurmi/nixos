{pkgs, ...} @ inputs: {
  imports = [
    ../../home/default.nix

    ../../home/i3
    ../../home/shell
    ../../home/programs
    ../../home/rclone
  ];

  home.file.".background-image".source = ./.wallpaper.jpg;

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
    # lua
    lua-language-server
    luajitPackages.luarocks_bootstrap
    luajitPackages.tiktoken_core
    lua

    tree-sitter
    cargo
    lynx
    zig
    just
    go
    nodejs_24
    python3Full
    rust-analyzer

    # java
    jdt-language-server
    lombok
    maven
  ];
}
