{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.05";

  home.username = "timkleinschmidt";
  home.homeDirectory = "/Users/timkleinschmidt";
  home.sessionVariables = {
    EDITOR = "vim";
    PATH = "/Applications/Postgres.app/Contents/Versions/latest/bin:\${PATH}";
    LC_ALL = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
    GDAL_LIBRARY_PATH = "/opt/homebrew/opt/gdal/lib/libgdal.dylib";
    GEOS_LIBRARY_PATH = "/opt/homebrew/opt/geos/lib/libgeos_c.dylib";
  };

  programs.zsh = { enable = true; };
  programs.starship = { enable = true; };

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    delta.enable = true;
    lfs.enable = true;
    userName = "Tim Kleinschmidt";
    userEmail = "tim.kleinschmidt@gmail.com";
    signing = {
      key = "3F74D3A286A02EED";
      signByDefault = true;
    };
    extraConfig = {
      github = { user = "Azd325"; };
      pull = { rebase = true; };
      fetch = { prune = true; };
      merge = { conflictstyle = "diff3"; };
    };
  };

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
    fnm
    gitAndTools.git-absorb
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
  ];
}