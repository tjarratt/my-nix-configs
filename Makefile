.PHONY: nixos
nixos:
	sudo nixos-rebuild switch --flake .

.PHONY: home
home:
	nix run --inputs-from . home-manager -- switch -b mine --flake .

.PHONY: clean
clean:
	nix-collect-garbage -d
