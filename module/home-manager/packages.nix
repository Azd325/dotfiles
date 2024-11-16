{ pkgs, ... }:
let
  nixTools = with pkgs; [
    cachix
    nixfmt
  ];

  gitTools = with pkgs.gitAndTools; [ git-absorb ];

  fonts = with pkgs; [
    jetbrains-mono
  ];

  devPackages = with pkgs; [ poetry ];

  homePackages = with pkgs; [
    coreutils
    curl
    rsync
  ];

in {
  home.packages = nixTools ++ gitTools ++ fonts ++ homePackages ++ devPackages;
  programs.home-manager.enable = true;
}
