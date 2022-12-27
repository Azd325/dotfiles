{ pkgs }:

let
  nixTools = with pkgs; [ cachix niv nixfmt nixpkgs-review ];

  gitTools = with pkgs.gitAndTools; [ git-absorb ];

  fonts = with pkgs; [
    fira-code
    fira-code-symbols
    jetbrains-mono
    source-code-pro
  ];

  guiTools = with pkgs; [ discord ];

  pythonPackages = with pkgs; [ poetry ];

  homePackages = with pkgs; [
    coreutils
    curl
    direnv
    # docker
    duf
    editorconfig-core-c
    fd
    fzf
    fnm
    gh
    ripgrep
    rsync
    shellcheck
    shfmt
    tmux
    vim
    wget
    youtube-dl
    wireguard-tools
    gnupg
  ];
in nixTools ++ fonts ++ gitTools ++ pythonPackages ++ guiTools ++ homePackages
