{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Tim Jarratt";
        email = "tjarratt@gmail.com";
      };

      alias = {
        ci = "commit";
        co = "checkout";
        di = "diff";
        st = "status";
      };

      init.defaultBranch = "main";
      commit.verbose = true;
      push.autoSetupRemote = true;
      pull.rebase = true;
      merge.conflictStyle = "zdiff3";

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
    };
  };
}
