{pkgs, ...}: {
  home.packages = with pkgs; [
    just

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
    jetbrains-toolbox
    kotlin-language-server
    gradle
    kotlin
  ];
}
