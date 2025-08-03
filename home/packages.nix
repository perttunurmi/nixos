{pkgs, ...}: {
  home.packages = with pkgs; [
    gradle
    zig
    just
    go
    python3Full

    # java
    jdt-language-server
    lombok
    maven

    # nix
    alejandra
    deadnix
    statix

    prettierd
    imagemagickBig
    trash-cli
    starship
    ripgrep
    zoxide
    tmux
    stow
    eza
    bat
    fzf
    fd
  ];
}
