{ ... }:

{
  programs.ssh.matchBlocks = {
    pihole = {
      user = "tjarratt";
      hostname = "pihole.local";
      port = 4022;
      extraOptions = {
        "StrictHostKeyChecking = "no";
        "ForwardAgent" = "yes";
      };
    };
  };
}
