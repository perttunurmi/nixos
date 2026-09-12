{ pkgs, ... }: {
  imports = [
  ];

  environment.defaultPackages = with pkgs; [
    man-pages
    vim
    tldr
    gcc
    clang
    clang-tools
    llvmPackages.openmp
    bear
    python3
    uv
  ];
}
