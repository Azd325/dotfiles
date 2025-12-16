{ pkgs, ... }:
{
  programs.git = {
    package = pkgs.gitFull;
    enable = true;
    lfs.enable = true;
    signing = {
      key = "3F74D3A286A02EED";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Tim Kleinschmidt";
        email = "tim.kleinschmidt@gmail.com";
      };
      branch = {
        sort = "-committerdate";
      };
      column = {
        ui = "auto";
      };
      commit = {
        verbose = true;
      };
      core = {
        commitgraph = true;
        fsmonitor = true;
        untrackedcache = true;
      };
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      feature = {
        manyFiles = true;
      };
      fetch = {
        all = true;
        prune = true;
        pruneTags = true;
        writeCommitGraph = true;
      };
      github = {
        user = "Azd325";
      };
      help = {
        autocorrect = "prompt";
      };
      init = {
        defaultBranch = "main";
      };
      merge = {
        conflictStyle = "zdiff3";
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      tag = {
        sort = "version:refname";
      };
    };
    ignores = [ ".envrc" ];
  };

  programs.delta.enable = true;
}
