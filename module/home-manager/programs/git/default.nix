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
      branch = { sort = "-committerdate"; };
      column = { ui = "auto"; };
      commit = { verbose = true; };
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
      feature = { manyFiles = true; };
      fetch = {
        all = true;
        prune = true;
        pruneTags = true;
        writeCommitGraph = true;
      };
      github = { user = "Azd325"; };
      help = { autocorrect = "prompt"; };
      init = { defaultBranch = "main"; };
      merge = { conflictStyle = "zdiff3"; };
      pull = { rebase = true; };
      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };
      rebase = { autoStash = true; };
      tag = { sort = "version:refname"; };
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
