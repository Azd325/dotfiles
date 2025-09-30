{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  ai = inputs."nix-ai-tools".packages.${pkgs.system};

  fonts = with pkgs; [
    fira-code
    fira-code-symbols
    jetbrains-mono
    source-code-pro
  ];

  homePackages = with pkgs; [
    cachix
    nixfmt-classic
    nixpkgs-fmt
    nixpkgs-review
    statix
    nixd
    clj-kondo
    lua54Packages.luacheck
    uv
    glow # Markdown renderer for CLI
    git-absorb
    git-filter-repo
    awscli2
    lazydocker
    lazygit
    lazyjj
    lazysql
    clojure
    coreutils
    curl
    dive
    duf
    editorconfig-core-c
    fd # fancy version of `find`
    gh
    gnugrep
    gnumake
    gnupg
    hyperfine # benchmarking tool
    imagemagick
    jq
    mosh # wrapper for `ssh` that better and not dropping connections
    ripgrep # better version of `grep`
    rsync
    rustup
    shellcheck
    shfmt
    wget
    yt-dlp
  ];

  aiPackages = [
    ai.copilot-cli
    ai.codex
    ai.crush
    ai.gemini-cli
    ai.goose-cli
    ai.opencode
    unstable.aichat
  ];

in {
  home.packages = fonts ++ homePackages ++ aiPackages;
  programs.home-manager.enable = true;
}
