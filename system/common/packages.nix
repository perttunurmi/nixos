{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    lsof
    cmake
    ninja
    pkg-config
    jq
    sqlite
    file
    ethtool
    typst
    sshfs
    magic-wormhole
    nix
    age
    borgbackup
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
    cargo
    go
    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
    llvmPackages_latest.clang-tools
  ];
}
