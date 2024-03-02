{
  description = "My personal NixOS configuration";

  inputs = {
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";

    devenv.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:cachix/devenv/main";

    alacritty-dracula-theme = {
      url = "github:dracula/alacritty";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, darwin, home-manager, devenv, alacritty-dracula-theme, self, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      extraArgs = {
        inherit nixpkgs home-manager devenv alacritty-dracula-theme;
        myFlake = self;
      };
    in {
      darwinConfigurations = {
        BER = darwin.lib.darwinSystem {
          specialArgs = extraArgs;
          system = "aarch64-darwin";
          modules = [
            ./system
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = extraArgs;
              home-manager.users.timkleinschmidt = import ./home;
            }
          ];
        };
      };
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in { default = pkgs.mkShell { buildInputs = with pkgs; [ ]; }; });
    };
}
