{ pkgs, inputs, ... }:
let
  # Package sources
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  ai = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  tools = inputs.tools.packages.${pkgs.stdenv.hostPlatform.system};

  # Font packages (from stable nixpkgs)
  fonts = [
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.jetbrains-mono
    pkgs.source-code-pro
  ];

  # Stable packages (from nixpkgs)
  stablePackages = [
    pkgs.age
    pkgs.awscli2
    pkgs.cachix
    pkgs.clj-kondo
    pkgs.clojure
    pkgs.coreutils
    pkgs.curl
    pkgs.devenv
    pkgs.dive
    pkgs.duf
    pkgs.editorconfig-core-c
    pkgs.ffmpeg
    pkgs.gallery-dl
    pkgs.gh
    pkgs.git-absorb
    pkgs.git-filter-repo
    pkgs.git-trim
    pkgs.glow # Markdown renderer for CLI
    pkgs.gnugrep
    pkgs.gnumake
    pkgs.gnupg
    pkgs.hyperfine # benchmarking tool
    pkgs.imagemagick
    pkgs.lazydocker
    pkgs.lazyjj
    pkgs.lazysql
    pkgs.lua54Packages.luacheck
    pkgs.magic-wormhole
    pkgs.mosh # wrapper for `ssh` that better and not dropping connections
    pkgs.nil
    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.nixpkgs-review
    pkgs.pandoc
    pkgs.rsync
    pkgs.rustup
    pkgs.sops
    pkgs.statix
    pkgs.tree
    pkgs.wget
    pkgs.yq
    pkgs.yt-dlp
  ];

  # Unstable packages (from nixpkgs-unstable)
  unstablePackages = [
    unstable.uv
  ];

  # Custom tool packages (from tools input)
  toolPackages = [
    tools.browser-cookies
    tools.browser-eval
    tools.browser-nav
    tools.browser-screenshot
    tools.browser-start
    tools.browser-stop
  ];

  # AI/ML packages (from llm-agents input)
  aiPackages = [
    ai.codex
    ai.copilot-cli
    ai.crush
    ai.gemini-cli
    ai.goose-cli
    ai.mistral-vibe
    ai.opencode
    ai.openspec
    ai.spec-kit
  ];

  # Mixed source AI packages (require both ai and unstable)
  mixedSourceAIPackages = [
    unstable.aichat
    unstable."fabric-ai"
  ];

in
{
  home.packages =
    fonts ++ stablePackages ++ unstablePackages ++ toolPackages ++ aiPackages ++ mixedSourceAIPackages;

  programs.home-manager.enable = true;
}
