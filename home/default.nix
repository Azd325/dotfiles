{ ... }: {
  imports = [ ./files ./packages.nix ./programs ];

  home.stateVersion = "23.05";

  home.username = "timkleinschmidt";
  home.homeDirectory = "/Users/timkleinschmidt";
  manual.manpages.enable = false;
  programs.man.enable = false;

  home = {
    sessionPath = [
      "$HOME/.local/bin"
      "/Users/timkleinschmidt/.config/emacs/bin"
      "/Applications/Postgres.app/Contents/Versions/latest/bin"
    ];
    sessionVariables = {
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
      GDAL_LIBRARY_PATH = "/opt/homebrew/opt/gdal/lib/libgdal.dylib";
      GEOS_LIBRARY_PATH = "/opt/homebrew/opt/geos/lib/libgeos_c.dylib";
    };
  };
}
