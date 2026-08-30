{
  lib,
  pkgs,
  ...
}:

{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/tjarratt/.config/sops/age/keys.txt";
  };

  home =
    let
      gitPlugins = pkgs.callPackage ./git-plugins.nix { };
    in
    {
      packages = with pkgs; [
        bat # fancy alternative for cat
        cowsay # moo
        delta # for git diffs
        departure-mono # mono-width terminal font
        file
        inetutils
        inotify-tools # mix test.watch
        lsof
        marp-cli
        nil # language-server for nix
        nixfmt
        pstree
        ripgrep
        tig
        tldr
        tree
        wl-clipboard

        gitPlugins.archaeology
        gitPlugins.praise

        erlang_28
        beam28Packages.elixir_1_20
        beam28Packages.elixir-ls

        rustc
        cargo
        clang
        clippy

        _1password-gui
        discord
        obsidian # a note a day ...
        signal-desktop
        slack
      ];

      shellAliases = {
        gst = "git status";
        vim = "nvim";

        pbcopy = "wl-copy"; # old habits die hard...
        pbpaste = "wl-paste";
      };

      file.".iex.exs".source = ./iex.exs;

      # whatever you do - DONT -- unless you read the docs
      # and you're sure of the consequences, and know what you're doing
      # and even then, don't change it after the first build
      #
      # how to change state version ?
      # DON'T
      #
      # how to change state version (for experts only)
      # don't (yet)
      stateVersion = "23.11";

      username = "tjarratt";
      homeDirectory = "/home/tjarratt";
    };

  nixpkgs.config.allowUnfreePredicate = (
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "discord"
      "obsidian"
      "slack"
    ]
  );

  programs = {
    fish.enable = true;
    home-manager.enable = true;
    zoxide.enable = true;
  };
}
