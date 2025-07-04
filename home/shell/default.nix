{ config, pkgs, ... }:
let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in
{
  imports = [
    ./common.nix
    ./starship.nix
    ./xdg.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # clean up ~
    LESSHISTFILE = cache + "/less/history";
    LESSKEY = c + "/less/lesskey";
    WINEPREFIX = d + "/wine";

    # set default applications
    EDITOR = "vim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";

    # enable scrolling in git diff
    DELTA_PAGER = "less -R";

    MANPAGER = "nvim +Man!";
  };

  programs.bash.enable = true;
  programs.zsh.enable = true;

  home.shellAliases = {
    "reload-rclone" = "systemctl --user restart rCloneMounts.service";
    g = "git";
    rm = "trash -v";
  };

  programs.bash.initExtra = ''
    stty werase undef
    bind '\C-w:unix-filename-rubout'

    PS1='\n\[\e[32;1m\][\[\e]0;\u@\h: \w\a\]\u@\h:\W]\$\[\e[0m\] '
  '';

  home.file.".inputrc".text = ''
    set completion-ignore-case On
  '';

  home.file.".config/bat/config".text = ''
    --style="numbers,changes,grid"
    --paging=auto
  '';

  home.packages = with pkgs; [
    trash-cli
    starship
    ripgrep
    zoxide
    neovim
    tmux
    stow
    eza
    bat
    fzf
    fd
  ];
}
