{ pkgs, zen-browser, ... }@inputs:
{
  imports = [
    ../../home/core.nix

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
    inputs.zen-browser.packages.x86_64-linux.default
    obsidian
    lua-language-server
    luajitPackages.luarocks_bootstrap
    luajitPackages.tiktoken_core
    tree-sitter
    cargo
    lynx
    btop
    zig
    just
    go
    nodejs_24
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
