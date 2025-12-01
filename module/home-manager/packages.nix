{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  ai = inputs."nix-ai-tools".packages.${pkgs.stdenv.hostPlatform.system};
  tools = inputs.tools.packages.${pkgs.stdenv.hostPlatform.system};

  fonts = with pkgs; [
    fira-code
    fira-code-symbols
    jetbrains-mono
    source-code-pro
  ];

  homePackages = with pkgs; [
    age
    cachix
    devenv
    nixfmt-rfc-style
    nixpkgs-review
    statix
    nil
    nixd
    clj-kondo
    lua54Packages.luacheck
    unstable.uv
    gallery-dl
    glow # Markdown renderer for CLI
    git-absorb
    git-filter-repo
    ffmpeg
    awscli2
    lazydocker
    lazyjj
    lazysql
    clojure
    coreutils
    curl
    dive
    duf
    editorconfig-core-c
    gh
    gnugrep
    gnumake
    gnupg
    hyperfine # benchmarking tool
    imagemagick
    mosh # wrapper for `ssh` that better and not dropping connections
    magic-wormhole
    pandoc
    rsync
    rustup
    sops
    tree
    wget
    yq
    yt-dlp

    tools.browser-start
    tools.browser-stop
    tools.browser-nav
    tools.browser-screenshot
    tools.browser-eval
    tools.browser-cookies
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
    unstable."fabric-ai"
    unstable.aichat
  ];

in
{
  home.packages = fonts ++ homePackages ++ aiPackages;
  programs.home-manager.enable = true;
}
