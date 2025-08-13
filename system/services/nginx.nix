{...}: {
  services.nginx = {
    enable = true;
    virtualHosts.localhost = {
      locations."/" = {
        return = "200 
        '<html>
          <body>
            <h1>It works</h1>
          </body>
        </html>'
        ";
        extraConfig = ''
          default_type text/html;
        '';
      };
    };
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
