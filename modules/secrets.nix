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

    age.sshKeyPaths = [ "/home/tjarratt/.ssh/id_ed25519_nixflix" ];
    age.keyFile = "/home/tjarratt/.config/sops/age/keys.txt";
  };
}
