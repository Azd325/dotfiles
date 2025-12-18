{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    geist-font # Sans-serif for UI (available system-wide)
    nerd-fonts.geist-mono # Monospace with Nerd Font icons
  ];
}
