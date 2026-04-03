{pkgs, ...}: {
  home.packages = with pkgs; [
    just

    # nix
    alejandra
    deadnix
    statix

    trash-cli
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
