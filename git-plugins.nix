{
  pkgs,
  writeShellApplication,
}:
let
  praise = writeShellApplication {
    name = "git-praise";
    runtimeInputs = [ pkgs.git ];
    excludeShellChecks = [ "SC2068" ];
    text = "git blame $@";
  };
  archaeology = writeShellApplication {
    name = "git-archaeology";
    runtimeInputs = [ pkgs.git ];
    text = ''
      if [ $# -ne 2 ]; then
        echo "Usage : git archaeology --commit-diff 'defp doctors_hate_this_one_weird_trick\(\)'"
        echo "Usage : git archaeology --commit-message 'there is no way I would ever forget this ...'"
        exit 1
      fi

      flag=''${1:-""}
      case "$flag" in
        "--commit-message")
          git log --grep "$2"
          ;;
        "--commit-diff")
          git log -S "$2"
          ;;
        *)
          echo "Unknown flag : '$flag'"
          echo "Usage : git archaeology --commit-diff 'defp doctors_hate_this_one_weird_trick\(\)'"
          echo "Usage : git archaeology --commit-message 'there is no way I would ever forget this ...'"
          exit 1
      esac
    '';
  };
in
{
  inherit archaeology praise;
}

