{
  config,
  ...
}:

{
  nixflix = {
    enable = true;

    mediaDir = "/home/tjarratt/nixflix/media";
    stateDir = "/home/tjarratt/nixflix/.state";

    caddy.enable = true;
    postgres.enable = true;

    # sonarr = {
    #   enable = true;
    #   config = {
    #   };
    # };

    # radarr = {
    #   enable = true;
    #   config = {
    #   };
    # };

    # prowlarr = {
    #   enable = true;
    #   config = {
    #   };
    # };

    # sabnzbd = {
    #   enable = true;
    #   settings = {
    #   };
    # };

    jellyfin = {
      enable = true;
      users.admin = {
        policy.isAdministrator = true;
        password = {
          _secret = config.sops.secrets."jellyfin/admin_password".path;
        };
      };
    };
  };
}
