{ pkgs, ... }: {

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    delta.enable = true;
    lfs.enable = true;
    userName = "Tim Kleinschmidt";
    userEmail = "tim.kleinschmidt@gmail.com";
    signing = {
      key = "3F74D3A286A02EED";
      signByDefault = true;
    };
    extraConfig = {
      core = {
        commitgraph = true;
        fsmonitor = true;
        untrackedcache = true;
      };
      init = { defaultBranch = "main"; };
      diff = { algorithm = "histogram"; };
      github = { user = "Azd325"; };
      pull = { rebase = true; };
      rebase = { autoStash = true; };
      fetch = {
        prune = true;
        writeCommitGraph = true;
      };
      merge = { conflictStyle = "zdiff3"; };
      feature = { manyFiles = true; };
    };
    ignores = [ ".envrc" ];
  };

  # GitHub CLI
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.gh.enable
  # Aliases config in ./gh-aliases.nix
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
    extensions = with pkgs; [ gh-eco gh-dash gh-actions-cache gh-cal ];
  };
}
