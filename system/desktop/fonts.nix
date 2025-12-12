{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
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
      # Persian Font
      vazir-fonts

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.symbols-only # symbols icon only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
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
