{ pkgs, devenv, ... }:
let
  nixTools = with pkgs; [
    cachix
    devenv.packages.${system}.devenv
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

  devPackages = with pkgs; [ clj-kondo lua54Packages.luacheck poetry ];

  homePackages = with pkgs; [
    bandwhich # display current network utilization by process
    bottom # fancy version of `top` with ASCII graphs
    coreutils
    curl
    du-dust # fancy version of `du`
    duf
    editorconfig-core-c
    fd # fancy version of `find`
    gh
    gnugrep
    gnumake
    gnupg
    hyperfine # benchmarking tool
    just # fancy version of `make`
    jq
    mosh # wrapper for `ssh` that better and not dropping connections
    ripgrep # better version of `grep`
    rsync
    shellcheck
    shfmt
    wget
    wireguard-tools
    youtube-dl
  ];

in {
  home.packages = nixTools ++ gitTools ++ fonts ++ homePackages ++ devPackages;
  programs.home-manager.enable = true;
}
