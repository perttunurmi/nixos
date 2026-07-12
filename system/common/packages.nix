{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    magic-wormhole
    tldr
    libsecret
    unzip
    gnutar
    tmux
    btop
    vim
    wget
    stow
    curl
    git
    lm_sensors
  ];
}
