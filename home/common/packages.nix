{ pkgs, ... }:
{
  home.packages = with pkgs; [
    just
    jujutsu
    delta

    # nix
    nixfmt
    nixfmt-tree
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
