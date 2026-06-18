{
  description = "My own, bespoke NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, home-manager, nixpkgs, nixvim, ... }@inputs:
    let
      system = "x86_64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      homeConfigurations = {
	tjarratt = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;
          extraSpecialArgs = {
            inherit nixvim; 
          };

          modules = [
	    ./home.nix
            ./cli.nix
            ./git.nix
            ./ssh.nix

            nixvim.homeManagerModules.nixvim 
            ./nixvim.nix
	  ];
        };
      };

      nixosConfigurations.pihole = nixpkgs.lib.nixosSystem {
        modules = [
          ./machines/pihole/configuration.nix
        ];
      };
    };
}
