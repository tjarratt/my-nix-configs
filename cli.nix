{ pkgs, lib, ... }:

{
  programs.direnv.enable = true;

  programs.readline = {
    enable = true;
    bindings = {
      "\\e[A" = "history-search-backward";
      "\\e[B" = "history-search-forward";
    };
    variables.completion-ignore-case = true;
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    defaultKeymap = "emacs"; 

    loginExtra = ''
      # set file descriptor count high ever that we never need to worry again
      # about working in an elixir project with a massive number of tests
      [[ $(ulimit -n) -lt 2048 ]] && ulimit -n 2048;
    '';
  };
}

