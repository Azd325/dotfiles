{ pkgs, ... }:
let
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
  ];

in {
  home.packages = fonts ++ homePackages;
  programs.home-manager.enable = true;
}
