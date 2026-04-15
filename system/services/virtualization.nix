{
  pkgs,
  username,
  ...
}:
{
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      package = pkgs.libvirt;
      qemu = {
        vhostUserPackages = with pkgs; [ virtiofsd ];
        package = pkgs.qemu;
        swtpm = {
          enable = false;
          package = pkgs.swtpm;
        };
      };
    };
    spiceUSBRedirection.enable = true;
  };

  users.users.${username}.extraGroups = [ "libvirtd" ];
  services.spice-vdagentd.enable = true;

  environment.systemPackages = with pkgs; [
    qemu
    distrobox
  ];
}
