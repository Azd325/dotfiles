{ pkgs, ... }:
{
  home.packages = [
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.jetbrains-mono
    pkgs.source-code-pro
  ];

  fonts.fontconfig.enable = true;
}
