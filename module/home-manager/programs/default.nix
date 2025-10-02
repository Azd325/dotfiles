{ ... }:
{
  imports = [
    ./editors
    ./git
    ./shells
  ];

  programs = {
    # fancy version of ls
    # https://nix-community.github.io/home-manager/options.html#opt-programs.eza.enable
    eza.enable = true;

    # Direnv, load and unload environment variables depending on the current directory.
    # https://direnv.net
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
    direnv = {
      enable = true;
      "nix-direnv".enable = true;
    };

    # https://nix-community.github.io/home-manager/options.html#opt-programs.fzf.enable
    fzf.enable = true;

    htop = {
      enable = true;
      settings.show_program_path = true;
    };

    # Bat, a substitute for cat.
    # https://github.com/sharkdp/bat
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
    bat = {
      enable = true;
      config.style = "plain";
    };

    # Zoxide, a faster way to navigate the filesystem
    # https://github.com/ajeetdsouza/zoxide
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
  };

  fonts.fontconfig.enable = true;
}
