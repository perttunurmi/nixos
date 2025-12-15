{
  pkgs,
  config,
  lib,
  agenix,
  ...
}: let
  systems = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPKIPf9KexBLaGjyn6ydyV3opUOA0TsTTXasxlZPyJmF"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG68e/3wA1WONkGrFadHB9NH1ka4uFOTJ4CLYkQc1IKN"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNACa1uf71iVOkNZmMJwmmaHHmgAemzHos4UtBNSEZA"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFBWHZJN4SJT+ARrioPZdDNNjNfucFD4/rHQO9T2fzx"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINHDfYPmi1G2NqOYSl4eQMruvYQHVZtfajrMluk4pA5n"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKJPPNtK8bsAF7JnQgV6wS8Va5o5U7FOii5Y18KvAfek"
  ];
in {
  users = {
    users.perttu = {
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

      openssh.authorizedKeys.keys = systems;
    };
  };

  systemd.tmpfiles.rules = [
    "f+ /var/lib/AccountsService/users/perttu  0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/perttu\\n"
    "L+ /var/lib/AccountsService/icons/perttu  - - - - ${./face}"
  ];
}
