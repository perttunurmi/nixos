{
  pkgs,
  username,
  ...
}: {
  programs.adb.enable = true;
  users.users.${username}.extraGroups = ["adbusers"];

  environment.systemPackages = with pkgs.unstable; [
    javaPackages.compiler.openjdk25
    android-studio
    android-tools
    kotlin
    gradle
    maven
    git
    scrcpy
    qemu
    SDL2
    libGL
  ];
}
