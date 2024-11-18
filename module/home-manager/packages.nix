{ pkgs, ... }:
let
  nixTools = with pkgs; [
    cachix
    nixfmt
    nixpkgs-fmt
    nixpkgs-review
    statix
  ];

  gitTools = with pkgs.gitAndTools; [ git-absorb ];

  fonts = with pkgs; [
    fira-code
    fira-code-symbols
    jetbrains-mono
    source-code-pro
  ];

  devPackages = with pkgs; [ clj-kondo lua54Packages.luacheck ];

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
    wireguard-tools
  ];

in {
  home.packages = nixTools ++ gitTools ++ fonts ++ homePackages ++ devPackages;
  programs.home-manager.enable = true;
}
