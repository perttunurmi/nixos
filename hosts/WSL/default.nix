{
  config,
  pkgs,
  ...
}: {
  imports = [
    <nixos-wsl/modules>
    (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")

    ../../modules/system.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "perttu";
    docker-desktop.enable = true;
    wslConf.network.hostname = "WSL";
    wslConf.automount.root = "/mnt";
    startMenuLaunchers = true;
  };

  # vscode server for wsl and ssh
  services.vscode-server.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {inherit (config.nixpkgs) config;};
    };
  };

  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions;
        [
          bbenoist.nix
          ms-python.python
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-ssh
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "remote-ssh-edit";
            publisher = "ms-vscode-remote";
            version = "0.47.2";
            sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
          }
        ];
    })
  ];

  programs.java = {
    enable = true;
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  system.stateVersion = "25.05";
}
