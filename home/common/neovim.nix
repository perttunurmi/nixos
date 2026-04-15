{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    lua51Packages.lua
    luajitPackages.luarocks_bootstrap
    luajitPackages.tiktoken_core

    prettierd

    zls
    nil
    metals
    taplo

    asm-lsp

    tree-sitter
    ripgrep
    fd
    gh
    git
    cargo
    nodejs_24
    ruff

    basedpyright
    bash-language-server
    gopls
    lua-language-server
    typescript-language-server
    rust-analyzer
    nixd
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    vimdiffAlias = true;
    vimAlias = true;
    withNodeJs = true;
  };
}
