{pkgs, ...}: {
  home.packages = with pkgs; [
    just

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
