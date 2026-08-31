{
  inputs,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.users.tjarratt = {
    imports = [
      inputs.sops-nix.homeManagerModules.sops

      ./home.nix
      ./cli.nix
      ./git.nix
      ./sops.nix
      ./ssh.nix
    ];
  };
}
