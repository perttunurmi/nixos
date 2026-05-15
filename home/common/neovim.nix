{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    lua
    nil
    asm-lsp
    codespell
    gotools
    prettierd
    stylua
    ruff
    pyright
    bash-language-server
    lua-language-server
    typescript-language-server
    rust-analyzer
    nixd

    gh
    git
    cargo
    nodejs_24
  ];
}
