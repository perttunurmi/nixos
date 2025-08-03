{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    lldb
    gdb
    tldr
    sqlite
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
    scrot
    gcc
    entr
  ];
}
