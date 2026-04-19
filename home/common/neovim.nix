{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    lua51Packages.lua
    luajitPackages.luarocks_bootstrap
    luajitPackages.tiktoken_core

    zls
    nil
    metals
    taplo
    asm-lsp
    codespell
    gotools
    prettier
    prettierd
    rustfmt
    stylua
    ruff
    pyright
    bash-language-server
    lua-language-server
    typescript-language-server
    rust-analyzer
    nixd

    tree-sitter
    ripgrep
    fd
    gh
    git
    cargo
    nodejs_24
  ];

  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #
  #   vimdiffAlias = true;
  #   vimAlias = true;
  #
  #   # withRuby = true;
  #   # withPython3 = true;
  #   # withNodeJs = true;
  # };
}
