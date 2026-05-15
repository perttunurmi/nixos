{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    magic-wormhole
    tldr
    libsecret
    unzip
    tmux
    btop
    vim
    wget
    curl
    git
    lm_sensors
  ];
}
