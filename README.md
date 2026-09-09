# My Exquisite Nix Configs

There are many nix configs, but these are my own.

## Structure

This repo has a nix flake that allows configuring either host-based nixos machines,
or home-manager for darwin-based machines.

## Adding a new machine

Secrets are managed by `sops-nix` and should you find yourself needing to add a new host
you'll want to follow [this guide](https://unmovedcentre.com/posts/secrets-management/#host-level-sops-nix-module) in detail

### tldr

On the new machine

* `/etc/ssh/ssh_host_ed25519_key < ssh-to-age` 
    * note the public key
* `mkdir -p $HOME/.config/sops/age`

On an existing host that already has `sops` setup correctly

* Add the public key aboveto `.sops.yaml`
* `sops updatekeys`
* `scp $HOME/.config/sops/age/keys.txt new-machine:~/.config/sops/age/keys.txt`

You may need to setup a per-user key as well in `$HOME/.ssh/id_rsa`, depending on your usecase.
