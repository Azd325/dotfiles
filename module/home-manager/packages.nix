{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  ai = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  tools = inputs.tools.packages.${pkgs.stdenv.hostPlatform.system};

  fonts = with pkgs; [
    fira-code
    fira-code-symbols
    jetbrains-mono
    source-code-pro
  ];

  homePackages = with pkgs; [
    age
    awscli2
    cachix
    clj-kondo
    clojure
    coreutils
    curl
    devenv
    dive
    duf
    editorconfig-core-c
    ffmpeg
    gallery-dl
    gh
    git-absorb
    git-filter-repo
    git-trim
    glow # Markdown renderer for CLI
    gnugrep
    gnumake
    gnupg
    hyperfine # benchmarking tool
    imagemagick
    lazydocker
    lazyjj
    lazysql
    lua54Packages.luacheck
    magic-wormhole
    mosh # wrapper for `ssh` that better and not dropping connections
    nil
    nixd
    nixfmt-rfc-style
    nixpkgs-review
    pandoc
    rsync
    rustup
    sops
    statix
    tree
    unstable.uv
    wget
    yq
    yt-dlp

    tools.browser-cookies
    tools.browser-eval
    tools.browser-nav
    tools.browser-screenshot
    tools.browser-start
    tools.browser-stop
  ];

  aiPackages = [
    ai.codex
    ai.copilot-cli
    ai.crush
    ai.gemini-cli
    ai.goose-cli
    ai.opencode
    ai.openspec
    ai.spec-kit
    unstable.aichat
    unstable."fabric-ai"
  ];

in
{
  home.packages = fonts ++ homePackages ++ aiPackages;
  programs.home-manager.enable = true;
}
