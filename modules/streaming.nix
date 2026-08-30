{
  config,
  inputs,
  ...
}:

let
  mediaDir = "/nixflix";
in
{
  imports = [
    inputs.nixflix.nixosModules.default
  ];

  nixflix = {
    enable = true;

    mediaDir = "${mediaDir}/media";
    stateDir = "${mediaDir}/.state";
    mediaUsers = [ "tjarratt" ];

    caddy.enable = true;
    caddy.addHostsEntries = true;

    postgres.enable = true;

    sonarr = {
      enable = true;
      config = {
        apiKey._secret = config.sops.secrets."sonarr/api_key".path;
        hostConfig.password._secret = config.sops.secrets."sonarr/password".path;
      };
    };

    radarr = {
      enable = true;
      config = {
        apiKey._secret = config.sops.secrets."radarr/api_key".path;
        hostConfig.password._secret = config.sops.secrets."radarr/password".path;
      };
    };

    lidarr = {
      enable = true;
      config = {
        apiKey._secret = config.sops.secrets."lidarr/api_key".path;
        hostConfig.password._secret = config.sops.secrets."lidarr/password".path;
      };
    };

    prowlarr = {
      enable = true;
      config = {
        apiKey._secret = config.sops.secrets."prowlarr/api_key".path;
        hostConfig.password._secret = config.sops.secrets."prowlarr/password".path;
        indexers = [

        ];
      };
    };

    usenetClients.sabnzbd = {
      enable = true;
      settings = {
        misc = {
          api_key._secret = config.sops.secrets."sabnzbd/api_key".path;
          nzb_key._secret = config.sops.secrets."sabnzbd/nzb_key".path;
          username._secret = config.sops.secrets."sabnzbd/username".path;
          password._secret = config.sops.secrets."sabnzbd/password".path;
        };

        servers = [

        ];
      };
    };

    jellyfin = {
      enable = true;
      apiKey._secret = config.sops.secrets."jellyfin/api_key".path;

      users.admin = {
        mutable = false;
        policy.isAdministrator = true;
        password._secret = config.sops.secrets."jellyfin/admin_password".path;
      };
    };

    seerr = {
      enable = true;
      apiKey._secret = config.sops.secrets."seerr/api_key".path;
    };

    recyclarr = {
      enable = true;
      cleanupUnmanagedProfiles.enable = true;
    };
  };

  sops.secrets = {
    "jellyfin/api_key" = { };
    "jellyfin/admin_password" = { };

    "sonarr/api_key" = { };
    "sonarr/password" = { };

    "radarr/api_key" = { };
    "radarr/password" = { };

    "lidarr/api_key" = { };
    "lidarr/password" = { };

    "prowlarr/api_key" = { };
    "prowlarr/password" = { };

    "sabnzbd/api_key" = { };
    "sabnzbd/nzb_key" = { };
    "sabnzbd/username" = { };
    "sabnzbd/password" = { };

    "seerr/api_key" = { };
  };
}
