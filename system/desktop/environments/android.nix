{
  pkgs,
  username,
  ...
}:
{
  users.users.${username}.extraGroups = [ "adbusers" ];

  programs.java.enable = true;

  environment.systemPackages = with pkgs; [
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
