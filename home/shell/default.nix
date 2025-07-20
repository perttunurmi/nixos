{config, ...}: let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./starship.nix
    ./xdg.nix
    ./neovim.nix
    ./rclone.nix
    ./xorg.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # clean up ~
    LESSHISTFILE = cache + "/less/history";
    LESSKEY = c + "/less/lesskey";
    WINEPREFIX = d + "/wine";

    GOPATH = c + "/go";

    # set default applications
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";

    # enable scrolling in git diff
    DELTA_PAGER = "less -R";
    MANPAGER = "nvim +Man!";
  };

  home.shellAliases = {
    g = "git";
    rm = "trash -v";
    v = "xsel -ob";
    c = "xsel -ib";
    zi = "cdi";
  };

  programs = {
    bash.enable = true;
    zsh.enable = true;
    fzf.enable = true;
    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };

    bash.initExtra = ''
      stty werase undef
      bind '\C-w:unix-filename-rubout'

      PS1='\n\[\e[32;1m\][\[\e]0;\u@\h: \w\a\]\u@\h:\W]\$\[\e[0m\] '
    '';
  };

  home.file.".inputrc".text = ''
    set completion-ignore-case on
    set show-all-if-ambiguous on
    $if Bash
      Space: magic-space
    $endif
  '';

  home.file.".config/bat/config".text = ''
    --style="numbers,changes,grid"
    --paging=auto
  '';

  home.file.".profile".text = ''
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
  '';

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_material_dark";
      theme_background = false;
      vim_keys = true;
    };
  };
}
