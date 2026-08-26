{
  description = "My own, bespoke NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      nixvim,
      ...
    }@inputs:
    {
      homeConfigurations = {
        tjarratt = home-manager.lib.homeManagerConfiguration {
          inherit nixpkgs;
          extraSpecialArgs = {
            inherit nixvim;
          };

          modules = [
            ./modules/home-manager/home.nix
            ./modules/home-manager/cli.nix
            ./modules/home-manager/git.nix
            ./modules/home-manager/ssh.nix

            nixvim.homeModules.nixvim
            ./modules/nvim/nixvim.nix
          ];
        };
      };

      nixosConfigurations.cerberos = nixpkgs.lib.nixosSystem {
        modules = [
          ./machines/cerberos/configuration.nix
        ];
      };

      nixosConfigurations.styx = nixpkgs.lib.nixosSystem {
      	modules = [
      	  ./machines/styx/configuration.nix

      	  home-manager.nixosModules.home-manager
      	  { home-manager.users.tjarratt = import ./modules/home-manager/home.nix; }
      	  { home-manager.users.tjarratt = import ./modules/home-manager/cli.nix; }
      	  { home-manager.users.tjarratt = import ./modules/home-manager/git.nix; }
      	  { home-manager.users.tjarratt = import ./modules/home-manager/ssh.nix; }

          nixvim.nixosModules.nixvim
          ./modules/nvim/nixvim.nix
      	];
      };
    };
}
