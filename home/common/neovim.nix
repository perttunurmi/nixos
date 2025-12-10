{
  pkgs,
  inputs,
  ...
}: let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.css
    p.dockerfile
    p.fish
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.gowork
    p.hcl
    p.javascript
    p.jq
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.rust
    p.toml
    p.typescript
    p.vue
    p.yaml
    p.latex
    p.html
    p.scss
    p.tsx
    p.typst
    p.regex
  ]);

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in {
  # Neovim configuration dependencies
  home.packages = with pkgs; [
    # lua
    lua51Packages.lua
    luajitPackages.luarocks_bootstrap
    luajitPackages.tiktoken_core

    # tools
    tree-sitter
    ripgrep
    fd
    black
    isort
    gh
    git
    cargo
    nodejs_24
    html-tidy
    actionlint
    yamllint
    gitlint
    ghostscript
    tectonic
    mermaid-cli
    sqlite
    texlivePackages.pdftex
    imagemagickBig

    # lsp
    typescript-language-server
    lua-language-server
    vscode-langservers-extracted
    jdt-language-server
    rust-analyzer
    bash-language-server
    pyright
    pylint
    yaml-language-server
    nixd
    just-lsp
  ];

  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimdiffAlias = true;
    vimAlias = true;
    withNodeJs = true;
  };
}
