{
  programs.ssh.matchBlocks = {
    cerberos = {
      user = "tjarratt";
      hostname = "cerberos.local";
      extraOptions = {
        "ForwardAgent" = "yes";
      };
    };

  };
}
