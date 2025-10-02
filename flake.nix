{
  description = "macOS + Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    darwin.url = "github:lnl7/nix-darwin/nix-darwin-25.05";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-ai-tools.url = "github:numtide/nix-ai-tools";
  };

  outputs =
    inputs:
    let
      darwin-system = import ./system/darwin.nix { inherit inputs username; };
      username = "timkleinschmidt";
    in
    {
      darwinConfigurations = {
        aarch64 = darwin-system "aarch64-darwin";
        x86_64 = darwin-system "x86_64-darwin";
      };

      formatter = inputs.nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ] (system: inputs.nixpkgs.legacyPackages.${system}.nixfmt-tree);

      checks = inputs.nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-darwin"
      ] (system:
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
        });
    };
}
