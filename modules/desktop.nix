{ pkgs, config, username, ... }: {
  users.users.${username}.packages = with pkgs; [
    chromium
    discord
    firefox
  ];

  systemd.tmpfiles.rules =
    [
      "f+ /var/lib/AccountsService/users/${username}  0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/${username}\\n" # notice the "\\n" we don't want nix to insert a new line in our string, just pass it as \n to systemd
      "L+ /var/lib/AccountsService/icons/${username}  - - - - ${../users/perttu/.face}" # you can replace the ${....} with absolute path to face icon
    ];
}
