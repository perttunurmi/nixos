{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
    neovim
    just
    jujutsu
    delta

    nixfmt
    nixfmt-tree
    deadnix

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
