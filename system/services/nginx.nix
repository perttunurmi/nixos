{
  config,
  pkgs,
  ...
}: {
  security.acme = {
    acceptTerms = true;
  };

  services.nginx = {
    enable = true;
    defaultHTTPListenPort = 85;
    defaultSSLListenPort = 445;

    virtualHosts.localhost = {
      locations."/" = {
        return = "200 '<html><body>It works</body></html>'";
        extraConfig = ''
          default_type text/html;
        '';
      };
    };
  };
  networking.firewall.allowedTCPPorts = [85 445];
}
