{ config, ... }: {
  programs.bash = {
    enable = true;

    shellAliases = {
      ls = "eza --color=always --group-directories-first";
      ll = "eza -l --color=always --group-directories-first";
      la = "eza -a --color=always --group-directories-first";
      lla = "eza -alhF --color=always --group-directories-first";
      "reload-rclone" = "systemctl --user restart rCloneMounts.service";
    };

    initExtra = ''
      stty werase undef
      bind '\C-w:unix-filename-rubout'

      PS1='\n\[\e[32;1m\][\[\e]0;\u@\h: \w\a\]\u@\h:\W]\$\[\e[0m\] '
    '';
  };
}
