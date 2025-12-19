{pkgs, ...}: {
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };
  };

  environment.systemPackages = with pkgs; [
    qemu
    distrobox
  ];
}
