{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    age
    sops
    ssh-to-age
  ];

  sops = {
    defaultSopsFile = ./../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    # ensure sops can decrypt secrets at boot-time
    # cannot use the files from /home for home-manager
    # because /home is not mounted when the decryption runs
    age = {
      keyFile = "/var/lib/sops-nix/keys.txt";
      generateKey = true;

      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };
  };
}
