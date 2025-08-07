{...}: {
  # The Broadcom STA package is marked as insecure, but is required for certain Broadcom Wi-Fi chipsets.
  # This override suppresses the warning to allow installation. Remove this override if you no longer use hardware
  # that requires broadcom-sta, or if a secure alternative driver becomes available.
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-57-6.16"
  ];
}
