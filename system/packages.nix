{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    borgbackup
    lldb
    gdb
    tldr
    libsecret
    clang-tools
    pciutils
    clang
    gnumake
    unzip
    tmux
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
