{
  description = "macOS + Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nix-darwin.url = "github:lnl7/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    llm-agents.url = "github:numtide/llm-agents.nix";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    tools.url = "github:Azd325/tools";
    tools.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-emacs-plus = {
      url = "github:d12frosted/homebrew-emacs-plus";
      flake = false;
    };

    homebrew-pulumi = {
      url = "github:pulumi/homebrew-tap";
      flake = false;
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, ... }@inputs:
    let
      username = "timkleinschmidt";
      system = "aarch64-darwin";
      darwin-system = import ./system/darwin.nix { inherit inputs username system; };
    in
    {
      darwinConfigurations = {
        BER = darwin-system;
      };

      # Nix formatter

      # This applies the formatter that follows RFC 166, which defines a standard format:
      # https://github.com/NixOS/rfcs/pull/166

      # To format all Nix files:
      # git ls-files -z '*.nix' | xargs -0 -r nix fmt
      # To check formatting:
      # git ls-files -z '*.nix' | xargs -0 -r nix develop --command nixfmt --check
      formatter.${system} = inputs.nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

      devShells.${system}.default =
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        in
        pkgs.mkShellNoCC {
          packages = [
            # Shell script for applying the nix-darwin configuration.
            # Run this to apply the configuration in this flake to your macOS system.
            (pkgs.writeScriptBin "apply-nix-darwin-configuration" ''
              echo "> Applying nix-darwin configuration..."

              echo "> Running darwin-rebuild switch as root..."
              sudo darwin-rebuild switch --verbose --flake .
              echo "> darwin-rebuild switch was successful ✅"

              echo "> macOS config was successfully applied 🚀"
            '')

            self.formatter.${system}
          ];
        };

      checks =
        inputs.nixpkgs.lib.genAttrs
          [
            "aarch64-darwin"
            "x86_64-darwin"
          ]
          (
            system:
            let
              pkgs = inputs.nixpkgs.legacyPackages.${system};
            in
            {
              statix = pkgs.runCommand "statix-check" { } ''
                ${pkgs.statix}/bin/statix check ${./.}
                touch $out
              '';

              deadnix = pkgs.runCommand "deadnix-check" { } ''
                ${pkgs.deadnix}/bin/deadnix --fail ${./.}
                touch $out
              '';
            }
          );
    };
}
