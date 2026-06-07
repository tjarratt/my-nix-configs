{ ... }:
{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;

    publish = {
      domain = true;
      enable = true;
      addresses = true;
    };

    reflector = true;
  };
}
