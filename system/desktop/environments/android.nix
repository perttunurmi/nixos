{
  lib,
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
    jdk21

    git

    scrcpy

    qemu
    SDL2
    libGL
  ];

  environment.sessionVariables = lib.mkAfter {
    ANDROID_SDK_HOME = "$XDG_CONFIG_HOME/.android";
  };

  services.udev.packages = with pkgs; [unstable.android-udev-rules];
}
