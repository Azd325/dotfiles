{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  aiPackages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  agentDir = ./agents;
  opencodeConfig = ./opencode.json;
in
{
  programs.opencode = {
    enable = true;
    package = aiPackages.opencode;
    settings = lib.importJSON opencodeConfig;
    agents = {
      config-safety-reviewer = agentDir + "/config-safety-reviewer.md";
      git-committer = agentDir + "/git-committer.md";
      review = agentDir + "/review.md";
    };
    skills = {
      git-release = ''
        ---
        name: git-release
        description: Create consistent releases and changelogs
        ---

        ## What I do

        - Draft release notes from merged PRs
        - Propose a version bump
        - Provide a copy-pasteable `gh release create` command
      '';

      interview = ''
        ---
        name: interview
        description: Interview me about the plan
        ---
        Read the plan file and interview me using the AskUserQuestion tool.
        Ask about: technical implementation,
        UI/UX, concerns, tradeoffs.
        Make sure the questions are not obvious.
        Be very in-depth and continue until it's complete, then write the spec.
      '';
    };
  };

  home.activation.cleanupOpencodeAgentLink = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    target="${config.home.homeDirectory}/.config/opencode/agent"
    if [ -L "$target" ]; then
      rm "$target"
    fi
  '';
}
