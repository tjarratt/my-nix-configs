{
  description = "My own, bespoke NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.pihole = nixpkgs.lib.nixosSystem {
        modules = [
          ./machines/pihole/configuration.nix
        ];
      };
    };
}
