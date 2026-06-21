{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    extraConfig = {
      core.pager = "${pkgs.delta}/bin/delta";
      interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";

      rebase.autostash = true;

      delta = {
        hyperlinks = true;
        navigate = true;
        side-by-side = true;
      };

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        renames = true;
      };

      commit.verbose = true;
    };
  };
}

