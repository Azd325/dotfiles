{ ... }: {
  imports = [ ./git ./shells ];

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;



  fonts.fontconfig.enable = true;
}
