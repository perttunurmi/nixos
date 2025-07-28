{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      qutebrowser = prev.qutebrowser.override {enableWideVine = true;};
    })
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-57-6.12.40"
  ];
}
