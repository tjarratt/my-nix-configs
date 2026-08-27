{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    age
    sops
    ssh-to-age
  ];

  sops = {
    defaultSopsFile = ./../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/tjarratt/.config/sops/age/keys.txt";
  };
}
