{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/tjarratt/.config/sops/age/keys.txt";
  };
}
