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
  };

  home.activation.cleanupOpencodeAgentLink = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    target="${config.home.homeDirectory}/.config/opencode/agent"
    if [ -L "$target" ]; then
      rm "$target"
    fi
  '';
}
