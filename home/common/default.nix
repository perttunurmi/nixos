{
  config,
  pkgs,
  lib,
  wsl,
  ...
}: let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./packages.nix
    ./starship.nix
    ./neovim.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # clean up ~
    LESSHISTFILE = cache + "/less/history";
    LESSKEY = c + "/less/lesskey";
    WINEPREFIX = d + "/wine";

    GOPATH = c + "/go";

    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";

    # set default applications
    EDITOR = "nvim";
    VISUAL = "nvim";

    # enable scrolling in git diff
    DELTA_PAGER = "less -R";
    MANPAGER = "nvim +Man!";
  };

  home.shellAliases = {
    g = "git";
    rm = "trash -v";
    zi = "cdi";

    ls = "eza --icons=auto";
    ll = "eza -l --icons=auto --git --git-repos";
    la = "eza -a --icons=auto --git";
    lla = "eza -la --icons=auto --git --git-repos";
  };

  programs = {
    bash.enable = true;
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

  programs.bash.profileExtra = ''
    if [ -d "$HOME/bin" ] ; then
      PATH="$HOME/bin:$PATH"
    fi

    if [ -d "$HOME/.local/bin" ] ; then
      PATH="$HOME/.local/bin:$PATH"
    fi

    PYTHON_HISTORY=~/.local/share/python_history
    NODE_REPL_HISTORY=~/.local/share/node_history
  '';

  home.file.".inputrc".text = ''
    set colored-stats On
    set colored-completion-prefix On

    set completion-ignore-case on
    set show-all-if-ambiguous on

    # set menu-complete-display-prefix on
    # set completion-prefix-display-length 5

    $if Bash
      Space: magic-space
    $endif
  '';

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      vim_keys = true;
    };
  };

  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";
      search_mode = "fuzzy";
    };
  };
}
