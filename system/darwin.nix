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
    ./homebrew.nix
    common
    hostBer
    system-config

    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs username userHome; };
      home-manager.users."${username}" = home-manager-config;
    }
  ];
}
