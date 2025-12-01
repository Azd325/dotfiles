{
  inputs,
  username,
  system,
}:
let
  userHome = "/Users/${username}";
in
inputs.nix-darwin.lib.darwinSystem {
  modules = [
    { nixpkgs.hostPlatform = system; }
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
    (import ./common.nix { inherit username userHome; })
    (import ./hosts/ber.nix { inherit username; })
    ../module/configuration.nix

    inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs username userHome; };
        users.${username} = ../module/home-manager;
      };
    }
  ];
}
