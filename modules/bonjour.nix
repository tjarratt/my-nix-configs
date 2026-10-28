{ ... }:
{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;

    settings = {
      reflector.enable-reflector = true;

      publish = {
        publish-domain = true;
        publish-addresses = true;

        disable-publishing = false;
      };
    };
  };
}
