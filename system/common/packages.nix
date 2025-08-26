{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    nix
    age
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
