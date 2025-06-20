{ pkgs, username, ... }: {
  users.users.${username}.packages = with pkgs; [
    chromium
    discord
    firefox
  ];
}
