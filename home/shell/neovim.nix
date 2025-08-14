{
  pkgs,
  inputs,
  lib,
  stylix,
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
  stylix.targets.neovim.enable = false;

  # Neovim configuration dependencies
  home.packages = with pkgs; [
    imagemagickBig
    # lua
    lua51Packages.lua
    luajitPackages.luarocks_bootstrap
    luajitPackages.tiktoken_core
    ghostscript
    mermaid-cli
    lynx

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
    google-java-format

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

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimdiffAlias = true;
    vimAlias = true;
    withNodeJs = true;

    plugins = [
      treesitterWithGrammars
    ];
  };

  home.file."./.config/nvim/lua/treesitter/init.lua".text = ''
    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';


  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };
}
