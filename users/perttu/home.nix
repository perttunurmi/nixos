{
  username,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  imports = [
    ./i3
    ./programs
    ./rclone
    ./shell
  ];

  # users.users.perttu.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCWzvRxBB4hWnes/OLWl7Mle5VYlnwNsd8zko8IrZ2/ perttu@nixos"
  #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBdudMkx0ecdlaBbKMBC7Tf8+bd4Kvu7kPpuloONSnVV u0_a322@localhost"
  # ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file.".background-image".source = ./.wallpaper.jpg;

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Perttu Nurmi";
    userEmail = "perttu.nurmi@gmail.com";
    extraConfig = {
      init.defaultBranch = "master";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    # lua
    lua-language-server
    luajitPackages.luarocks_bootstrap
    luajitPackages.tiktoken_core
    lua

    tree-sitter
    cargo
    lynx
    zig
    just
    go
    nodejs_24
    python3Full
    rust-analyzer

    # java
    jdt-language-server
    lombok
    maven

    ghostscript
    mermaid-cli
  ];
}
