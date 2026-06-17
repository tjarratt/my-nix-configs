.PHONY: update
update:
	nix run --inputs-from . home-manager -- switch -b mine --flake .

.PHONY: clean
clean:
	nix-collect-garbage -d
