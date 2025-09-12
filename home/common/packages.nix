{pkgs, ...}: {
  home.packages = with pkgs; [
    speedcrunch
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
  ];
}
