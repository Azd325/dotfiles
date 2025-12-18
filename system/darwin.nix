{
  inputs,
  username,
  system,
}:
let
  userHome = "/Users/${username}";
in
inputs.nix-darwin.lib.darwinSystem {
  # specialArgs: Custom arguments available to ALL system modules
  # Used to seed config options (like system.primaryUser) via lib.mkDefault
  # System modules should prefer reading config.system.primaryUser over using
  # username directly for better modularity and overridability
  specialArgs = {
    inherit username userHome;
  };

  modules = [
    { nixpkgs.hostPlatform = system; }
    inputs.sops-nix.darwinModules.sops
    inputs.stylix.darwinModules.stylix
    ./stylix.nix
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
    # Host-specific configuration (gets username/userHome via specialArgs)
    ./hosts/ber.nix

    inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
        # extraSpecialArgs: Arguments specific to home-manager modules
        # Duplicating username/userHome here for ergonomics in HM modules
        # HM modules could alternatively read config.system.primaryUser
        extraSpecialArgs = {
          inherit inputs username userHome;
        };
        users.${username} = ../modules/home-manager;
      };
    }
  ];
}
