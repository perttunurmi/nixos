{...}: {
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPKIPf9KexBLaGjyn6ydyV3opUOA0TsTTXasxlZPyJmF perttu@nixos"
    ];
  };
}
