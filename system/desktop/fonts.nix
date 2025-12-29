{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      material-design-icons

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts

      ubuntu-classic
      vazir-fonts

      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts._0xproto
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.droid-sans-mono
      nerd-fonts.zed-mono
      nerd-fonts.hack
      nerd-fonts.profont
      nerd-fonts.mononoki
      nerd-fonts.commit-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.adwaita-mono
      nerd-fonts.liberation
      nerd-fonts.terminess-ttf
      nerd-fonts.meslo-lg
      nerd-fonts.blex-mono
      nerd-fonts.dejavu-sans-mono
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Color Emoji"
      ];
      monospace = [
        "Liberation Mono"
        "Noto Color Emoji"
      ];
      emoji = ["Noto Color Emoji"];
    };

    fontDir.enable = true;
    fontconfig.useEmbeddedBitmaps = true;
    enableGhostscriptFonts = true;
  };
}
