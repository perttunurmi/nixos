{
  pkgs,
  inputs,
  ...
}: {
  stylix.targets.neovim.enable = false;

  home.packages = with pkgs; [
    lua51Packages.lua
    luajitPackages.luarocks_bootstrap
    luajitPackages.tiktoken_core

    prettierd

    zig
    zls
    nil
    metals


    tree-sitter
    ripgrep
    fd
    gh
    git
    cargo
    nodejs_24
    html-tidy
    actionlint
    yamllint
    gitlint
    sqlite
    ruff

    typescript-language-server
    lua-language-server
    vscode-langservers-extracted
    jdt-language-server
    rust-analyzer
    bash-language-server
    basedpyright
    yaml-language-server
    nixd
    nil
    just-lsp
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimdiffAlias = true;
    vimAlias = true;
    withNodeJs = true;
  };
}
