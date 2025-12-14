{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    magic-wormhole
    nix
    age
    borgbackup
    lldb
    gdb
    tldr
    libsecret
    pciutils
    gnumake
    unzip
    tmux
    btop
    vim
    wget
    curl
    git
    sysstat
    lm_sensors
    scrot
    gcc
    entr
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
    clang-tools
    clang
  ];
}
