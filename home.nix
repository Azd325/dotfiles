{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.05";

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  home.packages = with pkgs; [
    cachix # adding/managing alternative binary caches hosted by Cachix
    coreutils
    curl
    direnv
    duf
    editorconfig-core-c
    fd
    fzf
    gitAndTools.git-absorb
    gitAndTools.gitFull
    niv # easy dependency management for nix projects
    nixfmt
    ripgrep
    rsync
    shellcheck
    shfmt
    tmux
    vim
    wget
    youtube-dl
    zsh
  ];
}
