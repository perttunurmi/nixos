{
  pkgs,
  username,
  ...
}: {
  programs.adb.enable = true;
  users.users.${username}.extraGroups = ["adbusers"];

  environment.systemPackages = with pkgs.unstable; [
    android-studio
    android-tools
    kotlin
    gradle
    maven
    javaPackages.compiler.openjdk25
    git
    scrcpy
    qemu
    SDL2
    libGL
  ];

  virtualisation.waydroid.enable = true;
}
