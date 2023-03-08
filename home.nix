{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "vim";
    PATH =
      "/Users/timkleinschmidt/bin:/Users/timkleinschmidt/.emacs.d/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:\${PATH}";
    LC_ALL = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
    GDAL_LIBRARY_PATH = "/opt/homebrew/opt/gdal/lib/libgdal.dylib";
    GEOS_LIBRARY_PATH = "/opt/homebrew/opt/geos/lib/libgeos_c.dylib";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    initExtra = ''
      # FNM
      eval "$(fnm env --use-on-cd)"

      # Pyenv
      export PYENV_ROOT=$HOME/.pyenv
      if [[ -e $PYENV_ROOT ]]; then
        export PATH=$PYENV_ROOT/bin:$PATH
        eval "$(pyenv init --path)"
      fi
    '';
  };
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
      diff = { algorithm = "histogram"; };
      github = { user = "Azd325"; };
      pull = { rebase = true; };
      rebase = { autoStash = true; };
      fetch = { prune = true; };
      merge = { conflictStyle = "zdiff3"; };
    };
    ignores = [ ".envrc" ];
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      editorconfig.editorconfig
      ms-azuretools.vscode-docker
      ms-python.python
    ];
  };

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  fonts.fontconfig.enable = true;

  home.packages = import ./home/packages.nix { inherit pkgs; };

  home.file.".doom.d" = { source = files/doom-emacs; };
  home.file.".shadow-cljs" = { source = files/shadow-cljs; };
  home.file.".yarnrc.yml" = { source = files/.yarnrc.yml; };

}
