{ config, lib, pkgs, ... }:

{
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings = {
    substituters = [ "https://cache.nixos.org/" ];
    trusted-public-keys =
      [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];

    trusted-users = [ "@admin" ];

    auto-optimise-store = true;

    experimental-features = [ "nix-command" "flakes" ];

    extra-platforms = lib.mkIf (pkgs.system == "aarch64-darwin") [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };

  nix.configureBuildUsers = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Shells -----------------------------------------------------------------------------------------

  # Add shells installed by nix to /etc/shells file
  #environment.shells = with pkgs; [ bashInteractive zsh ];

  # Install and setup ZSH to work with nix(-darwin) as well
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
