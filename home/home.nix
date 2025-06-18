{ config, pkgs, ... }:

{
  home.username = "perttu";
  home.stateVersion = "25.05";

  xresources.properties = {
    "Xft.dpi" = 100;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

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

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 1;
      font.normal = {
        family = "Iosevka NerdFont";
        style = "Regular";
      };
      font.size = 16;
    };
  };

  home.file.".config/bat/config".text = ''
    --style="numbers,changes,grid"
    --paging=auto
  '';


  home.packages = with pkgs; [
    rclone

    # basics
    ripgrep
    neovim
    zoxide
    tmux
    stow
    git
    bat
    eza
    fzf
    fd
    gh

    # archives
    zip
    xz
    unzip
    p7zip

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # systemd.user.services.rCloneMounts = {
  #   Unit = {
  #     Description = "Mount all rClone configurations";
  #     After = [ "network-online.target" ];
  #   };
  #   Service = let home = config.home.homeDirectory; in
  #     {
  #       Type = "forking";
  #       ExecStartPre = "${pkgs.writeShellScript "rClonePre" ''
  #     remotes=$(${pkgs.rclone}/bin/rclone --config=${home}/.config/rclone/rclone.conf listremotes)
  #     for remote in $remotes;
  #     do
  #     name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
  #     /usr/bin/env mkdir -p ${home}/"$name"
  #     done
  #     '' }";
  #
  #       ExecStart = "${pkgs.writeShellScript "rCloneStart" ''
  #     remotes=$(${pkgs.rclone}/bin/rclone --config=${home}/.config/rclone/rclone.conf listremotes)
  #     for remote in $remotes;
  #     do
  #     name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
  #     ${pkgs.rclone}/bin/rclone --config=${home}/.config/rclone/rclone.conf --vfs-cache-mode writes --ignore-checksum mount "$remote" "$name" &
  #     done
  #     '' }";
  #
  #       ExecStop = "${pkgs.writeShellScript "rCloneStop" ''
  #     remotes=$(${pkgs.rclone}/bin/rclone --config=${home}/.config/rclone/rclone.conf listremotes)
  #     for remote in $remotes;
  #     do
  #     name=$(/usr/bin/env echo "$remote" | /usr/bin/env sed "s/://g")
  #     /usr/bin/env fusermount -u ${home}/"$name"
  #     done
  #     '' }";
  #     };
  #   Install.WantedBy = [ "default.target" ];
  # };

}
