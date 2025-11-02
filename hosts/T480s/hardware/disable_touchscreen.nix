{lib, ...}: {
  services.udev.extraRules = lib.mkAfter "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"04f3\", ATTRS{idProduct}==\"2398\", ATTR{authorized}=\"0\"";
}
