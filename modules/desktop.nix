{
  pkgs,
  config,
  username,
  ...
}:
{

  users.users.${username}.packages = with pkgs; [
    chromium
    discord
    firefox
    brave
    android-tools
    scrcpy
    steam
    mangohud
    gamescope
  ];

  systemd.tmpfiles.rules = [
    "f+ /var/lib/AccountsService/users/${username}  0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/${username}\\n" # notice the "\\n" we don't want nix to insert a new line in our string, just pass it as \n to systemd
    "L+ /var/lib/AccountsService/icons/${username}  - - - - ${../users/${username}/.face}" # you can replace the ${....} with absolute path to face icon
  ];

  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;

    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.gamemode.enable = true;

}
