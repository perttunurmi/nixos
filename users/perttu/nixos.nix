{ config, lib, ... }:
{
    users.users.perttu.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKkrP5KKoBa05b9R7ZRRo4jqrPXjlyZujMNAvmiIw3FK perttu@T480s"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDLkRxTS7oVygwjGbPaYuTrPZXkN5Usfnbl1ZZBwCO7G VMware SSH Key"
    ];
}
