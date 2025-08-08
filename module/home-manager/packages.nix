{ pkgs, ... }:
let
  nixTools = with pkgs; [
    cachix
    nixfmt
    nixpkgs-fmt
    nixpkgs-review
    statix
  ];

  fonts = with pkgs; [
    fira-code
    fira-code-symbols
    jetbrains-mono
    source-code-pro
  ];

  devPackages = with pkgs; [ clj-kondo lua54Packages.luacheck uv ];

  devOpsPackages = with pkgs; [
    git-absorb
    awscli2
    lazydocker
    lazygit
    lazyjj
    lazysql
  ];

  homePackages = with pkgs; [
    coreutils
    curl
    duf
    editorconfig-core-c
    fd # fancy version of `find`
    gh
    gnugrep
    gnumake
    gnupg
    hyperfine # benchmarking tool
    jq
    mosh # wrapper for `ssh` that better and not dropping connections
    ripgrep # better version of `grep`
    rsync
    shellcheck
    shfmt
    wget
  ];

in {
  home.packages = nixTools ++ fonts ++ devPackages ++ devOpsPackages ++ homePackages;
  programs.home-manager.enable = true;
}
