{
  description = "My own, bespoke NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixflix = {
      url = "github:kiriwalawren/nixflix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      nixflix,
      nixvim,
      sops-nix,
      ...
    }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ];
    in
    {
      formatter = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        pkgs.nixfmt
      );

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
        system = "x86_64-linux";

        modules = [
          ./machines/styx/configuration.nix

          sops-nix.nixosModules.sops
          ./modules/secrets.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.users.tjarratt = {
              imports = [
                inputs.sops-nix.homeManagerModules.sops
                ./modules/home-manager/home.nix
                ./modules/home-manager/cli.nix
                ./modules/home-manager/git.nix
                ./modules/home-manager/ssh.nix
              ];
            };
          }

          nixvim.nixosModules.nixvim
          ./modules/nvim/nixvim.nix

          nixflix.nixosModules.default
          ./modules/streaming.nix
        ];
      };
    };
}
