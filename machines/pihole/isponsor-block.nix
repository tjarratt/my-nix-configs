{ pkgs, ... }:

{
  systemd.services.insponsorblock = {
    enable = true;

    description = "Block Youtube ads automatically";

    # ensure service starts when machine boots
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "tjarratt";
      ExecStart = "${pkgs.isponsorblocktv}/bin/iSponsorBlockTV";
      Restart = "always";

      StandardOutput = "journal";
      StandardError = "journal";
    };
  };
}
