{
  description = "My personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
  };

  outputs = inputs : let
    darwin-system = import ./system/darwin.nix {inherit inputs username;};
    username = "timkleinschmidt";
  in {
    darwinConfigurations = {
      aarch64 = darwin-system "aarch64-darwin";
      x86_64 = darwin-system "x86_64-darwin";
    };
  };
}
