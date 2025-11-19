{pkgs, ...}: {
  home.packages = with pkgs; [
    just
    emacs

    # nix
    alejandra
    deadnix
    statix

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

    # projekti
    kotlin-language-server
    gradle
    kotlin
  ];
}
