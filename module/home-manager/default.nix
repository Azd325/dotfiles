{ config, ... }: {
  imports = [ ./files ./packages.nix ./programs ];

  home.stateVersion = "24.05";

  home.username = "timkleinschmidt";
  home.homeDirectory = "/Users/timkleinschmidt";
  manual.manpages.enable = false;
  programs.man.enable = false;

  home = {
    sessionPath = [
    ];
    sessionVariables = {
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
    };
  };
}
