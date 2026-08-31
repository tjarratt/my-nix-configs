{
  inputs,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = { inherit inputs; };

  home-manager.users.tjarratt = {
    imports = [
      ./home.nix
      ./cli.nix
      ./git.nix
      ./sops.nix
      ./ssh.nix
    ];
  };
}
