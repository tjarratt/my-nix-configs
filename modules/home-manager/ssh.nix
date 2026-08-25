{ ... }:

{
  programs.ssh.matchBlocks = {
    pihole = {
      user = "tjarratt";
      hostname = "cerberos.local";
      port = 4022;
      extraOptions = {
        "StrictHostKeyChecking" = "no";
        "ForwardAgent" = "yes";
      };
    };

    cerberos = {
      user = "tjarratt";
      hostname = "cerberos.local";
      port = 4022;
      extraOptions = {
        "StrictHostKeyChecking" = "no";
        "ForwardAgent" = "yes";
      };
    };

  };
}
