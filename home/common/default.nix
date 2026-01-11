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

  home.packages = with pkgs; [coreutils];

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
  ];

  programs.dircolors.enable = true;

  # add environment variables
  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";

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
    zsh = {
      enable = true;
      enableCompletion = true;
      dotDir = "${config.xdg.configHome}/zsh";
      defaultKeymap = "emacs";
      setOptions = [
        "autocd"
        "autopushd"
        "extendedhistory"
        "histignorealldups"
        "histignorespace"
        "incappendhistory"
        "interactivecomments"
        "nobeep"
        "nomatch"
        "notify"
        "sharehistory"
      ];

      initContent = ''
                WORDCHARS=''${WORDCHARS/\/}
              KEYTIMEOUT=1

        # Ctrl+Left/Right for word navigation
                bindkey "^[[1;5D" backward-word
                bindkey "^[[1;5C" forward-word

                bindkey "^[[3;5~" kill-word
      '';

      completionInit = builtins.concatStringsSep "\n" [
        "zstyle ':completion:*' list-colors \"''\${(s.:.)LS_COLORS:-di=34:ln=35:so=32:pi=33:ex=31}\""
        "zstyle ':completion:*' group-name ''"
        "zstyle ':completion:*' format '%F{yellow}%d%f'"
        "zstyle ':completion:*' menu select=2"
        "zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*'"
        "zstyle ':completion:*' use-cache yes"
      ];
    };

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
    '';
  };

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
    flags = ["--disable-up-arrow"];
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";
      search_mode = "fuzzy";
    };
  };
}
