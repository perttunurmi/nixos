{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bitwarden-cli
    magic-wormhole
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

    scala
    scalafmt
    scalafix
    scala-cli
    sbt
  ];
}
