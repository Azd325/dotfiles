{
  description = "Tim's darwin system";

  inputs = {
    # Package sets
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, darwin, home-manager, ... }@inputs:
    let

      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs-unstable.lib)
        attrValues makeOverridable optionalAttrs singleton;

      nixpkgsConfig = { config = { allowUnfree = true; }; };

      homeManagerStateVersion = "22.11";

      primaryUserInfo = {
        username = "timkleinschmidt";
        fullName = "Tim Kleinschmidt";
        email = "tim.kleinschmidt@gmail.com";
      };

      nixDarwinCommonModules = attrValues self.darwinModules ++ [
        home-manager.darwinModules.home-manager
        ({ config, ... }:
          let inherit (config.users) primaryUser;
          in {
            nixpkgs = nixpkgsConfig;
            # Hack to support legacy worklows that use `<nixpkgs>` etc.
            # nix.nixPath = { nixpkgs = "${primaryUser.nixConfigDirectory}/nixpkgs.nix"; };
            nix.nixPath = { nixpkgs = "${inputs.nixpkgs-unstable}"; };
            # `home-manager` config
            users.users.${primaryUser.username}.home =
              "/Users/${primaryUser.username}";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${primaryUser.username} = {
              imports = attrValues self.homeManagerModules;
              home.stateVersion = homeManagerStateVersion;
              home.user-info = config.users.primaryUser;
            };
            # Add a registry entry for this flake
            nix.registry.my.flake = self;
          })
      ];
    in {
      darwinModules = {
        tim-bootstrap = import ./darwin/bootstrap.nix;
        tim-general = import ./darwin/general.nix;
        tim-homebrew = import ./darwin/homebrew.nix;

        users-primaryUser = import ./modules/darwin/users.nix;
      };
      homeManagerModules = {
        tim-home = import ./home.nix;
        home-user-info = { lib, ... }: {
          options.home.user-info = (self.darwinModules.users-primaryUser {
            inherit lib;
          }).options.users.primaryUser;
        };
      };

      darwinConfigurations = rec {
        BER = darwinSystem {
          system = "aarch64-darwin";
          modules = nixDarwinCommonModules ++ [{
            users.primaryUser = primaryUserInfo;
            networking.computerName = "Tim’s 💻";
            networking.hostName = "BER";
          }];
        };
      };

      # Overlays --------------------------------------------------------------- {{{

      overlays = {
        # Overlay useful on Macs with Apple Silicon
        apple-silicon = final: prev:
          optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            # Add access to x86 packages system is running Apple Silicon
            pkgs-x86 = import inputs.nixpkgs-unstable {
              system = "x86_64-darwin";
              inherit (nixpkgsConfig) config;
            };
          };
      };
    };
}
