{
  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.firewall.allowedUDPPorts = [ 53 ];

  services = {
    pihole-ftl = {
      enable = true;
      lists = [
        {
          url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          type = "block";
          enabled = true;
          description = "Steven Black's HOSTS";
        }
      ];

      settings = {
        # quad9, THEN cloudflare
        dns.upstreams = [
          "9.9.9.9"
          "1.1.1.1"
        ];

        dns.hosts = [
          # nixflix entries
          # https://kiriwalawren.github.io/nixflix/examples/basic-setup/#service-access
          "192.168.0.29 jellyfin.nixflix"
          "192.168.0.29 seerr.nixflix"
        ];
      };
    };

    pihole-web = {
      enable = true;
      ports = [ "80" ];
    };
  };
}
