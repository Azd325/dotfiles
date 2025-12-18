{ pkgs, ... }:
{
  stylix = {
    enable = true;

    # Color scheme - Catppuccin Mocha
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";

    # Fonts
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.geist-mono;
        name = "GeistMono Nerd Font";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      serif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 13;
        applications = 12;
        desktop = 10;
        popups = 10;
      };
    };

    opacity = {
      terminal = 1.0;
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };
  };
}
