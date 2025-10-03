{ inputs, username }:
system:
let
  system-config = import ../module/configuration.nix;
  home-manager-config = import ../module/home-manager;
  userHome = "/Users/${username}";
  common = import ./common.nix { inherit username userHome; };
  hostBer = import ./hosts/ber.nix { inherit username; };
in
inputs.darwin.lib.darwinSystem {
  inherit system;
  modules = [
    inputs.sops-nix.darwinModules.sops
    inputs.nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = true;
        user = username;
        group = "admin";
        autoMigrate = false;
        enableRosetta = true;
        mutableTaps = false;
        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
          "d12frosted/homebrew-emacs-plus" = inputs.homebrew-emacs-plus;
          "pulumi/homebrew-tap" = inputs.homebrew-pulumi;
        };
      };
    }
    ./sops.nix
    ./homebrew.nix
    common
    hostBer
    system-config

    inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs username userHome; };
        users = {
          "${username}" = home-manager-config;
        };
      };
    }
  ];
}
