{pkgs, ...}: {
  environment = {
    systemPackages = [ pkgs.qemu ];
  };

  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [virtiofsd];
  };

  boot.extraModprobeConfig = "options kvm_intel nested=1";
}
