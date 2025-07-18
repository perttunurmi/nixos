{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    sqlite
    texliveFull
    libsecret
    clang-tools
    pciutils
    docker
    clang
    gnumake
    unzip
    tmux
    htop
    btop
    vim
    neovim
    wget
    curl
    git
    sysstat
    lm_sensors
    dart-sass
    hugo
    scrot
    gcc
  ];
}
