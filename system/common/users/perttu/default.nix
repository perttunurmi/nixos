{...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’!
  users.users.perttu = {
    isNormalUser = true;
    description = "Perttu" + " " + "Nurmi";
    extraGroups = [
      "perttu"
      "gamemode"
      "networkmanager"
      "wheel"
      "docker"
      "audio"
      "video"
      "plugdev"
      "input"
      "lp"
      "scanner"
      "libvirt"
      "kvm"
      "wireshark"
      "samba"
    ];
  };

  # face for the user
  systemd.tmpfiles.rules = [
    "f+ /var/lib/AccountsService/users/perttu  0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/perttu\\n" # notice the "\\n" we don't want nix to insert a new line in our string, just pass it as \n to systemd
    "L+ /var/lib/AccountsService/icons/perttu  - - - - ${./face}"
  ];

  users.users.perttu = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPKIPf9KexBLaGjyn6ydyV3opUOA0TsTTXasxlZPyJmF perttu@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG68e/3wA1WONkGrFadHB9NH1ka4uFOTJ4CLYkQc1IKN perttu@NixOS"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNACa1uf71iVOkNZmMJwmmaHHmgAemzHos4UtBNSEZA perttu@T480s"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFBWHZJN4SJT+ARrioPZdDNNjNfucFD4/rHQO9T2fzx perttu@W11"
    ];
  };
}
