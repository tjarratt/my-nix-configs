{ pkgs, ... }:
{
  systemd.services.shutdown-at-night = {
    description = "Power off at night";
    script = ''
      ${pkgs.systemd}/bin/shutdown -h now "It's too dang late."
    '';
    serviceConfig.Type = "oneshot";
  };

  systemd.timers.shutdown-at-night = {
    description = "Invokes the systemd job shutdown-at-night on a timer";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 23:06:00";
      Persistent = true;
    };
  };
}
