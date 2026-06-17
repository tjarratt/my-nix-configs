{ pkgs, nixvim, ...}:

{
  home = 
    let
      gitPlugins = pkgs.callPackage ./git-plugins.nix { };
    in
    {
    packages = with pkgs; [
      # nixvim.homeModules.nixvim

      bat # fancy alternative for cat
      cowsay # moo
      delta # for git diffs
      # departure-mono # mono-width terminal font
      # elixir-ls 
      # erlang_28
      # elixir_1_20
      # inetutils
      # lsof
      # nil # language-server for nix
      # pstree
      ripgrep
      tig
      tldr
      # tree
      gitPlugins.archaelogy
      gitPlugins.praise
    ];

    shellAliases = {
     gst = "git status";
     
     vim = "nvim";
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
    homeDirectory = "/Users/tjarratt";
  };

  programs = {
    fish.enable = true;
    zoxide.enable = true;
  };
}
