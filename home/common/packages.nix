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

    gradle
    kotlin
  ];
}
