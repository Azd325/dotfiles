{
  description = "My personal NixOS configuration";

  inputs = {
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";

    alacritty-dracula-theme = {
      url = "github:dracula/alacritty";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
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
