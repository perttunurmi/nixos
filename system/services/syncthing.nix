{ username, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "${username}";
    configDir = "/home/${username}/.config/syncthing";
    dataDir = "/home/${username}/share";
  };
}
