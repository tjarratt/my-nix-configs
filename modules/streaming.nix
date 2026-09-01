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
          # nzbs ...
          {
            enable = true;
            name = "NZBgeek";
            apiKey._secret = config.sops.secrets."indexer-api-keys/NZBGeek".path;
          }

          # everything else
          {
            enable = true;
            name = "Nyaa.si";
            baseUrl = "https://nyaa.si/";
            radarr_compatibility = true;
            sonarr_compatibility = true;
          }
          {
            enable = true;
            name = "YTS";
            baseUrl = "https://yts.bz/";
          }
          {
            enable = true;
            name = "The Pirate Bay";
            baseUrl = "https://thepiratebay.org/";
          }
          {
            enable = true;
            name = "LimeTorrents";
            baseUrl = "https://www.limetorrents.fun/";
          }
          {
            enable = true;
            name = "TorrentDownload";
            baseUrl = "https://www.torrentdownload.info/";
          }
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
          {
            name = "Eweka";
            host = "news.eweka.nl";
            port = 563;
            ssl = true;
            username._secret = config.sops.secrets."usenet/eweka/username".path;
            password._secret = config.sops.secrets."usenet/eweka/password".path;
            connections = 50;
            priority = 0;
            retention = 3000;
          }
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

    "usenet/eweka/username" = { };
    "usenet/eweka/password" = { };

    "indexer-api-keys/NZBGeek" = { };
  };
}
