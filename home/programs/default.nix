{ ... }: {
  imports = [ ./editors ./git ./shells ];

  # fancy version of ls
  # https://nix-community.github.io/home-manager/options.html#opt-programs.eza.enable
  programs.eza = {
    enable = true;
    enableAliases = true;
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # https://nix-community.github.io/home-manager/options.html#opt-programs.fzf.enable
  programs.fzf.enable = true;

  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat.enable = true;
  programs.bat.config = { style = "plain"; };

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide.enable = true;

  # https://nix-community.github.io/home-manager/options.html#opt-programs.zellij.enable
  programs.zellij = {
    enable = true;
    settings = {
      # https://github.com/rose-pine/zellij
      theme = "rose-pine";
      themes = {
        rose-pine = {
          bg = "#191724";
          fg = "#e0def4";
          red = "#eb6f92";
          green = "#31748f";
          blue = "#9ccfd8";
          yellow = "#f6c177";
          magenta = "#c4a7e7";
          orange = "#fe640b";
          cyan = "#ebbcba";
          black = "#26233a";
          white = "#e0def4";
        };
      };
    };
  };

  fonts.fontconfig.enable = true;
}
