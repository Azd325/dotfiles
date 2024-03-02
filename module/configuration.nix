{pkgs, ...}: {
  nix = {
    settings = {
      # https://github.com/NixOS/nix/issues/7273
      auto-optimise-store = false;
      builders-use-substitutes = true;
      experimental-features = [ "flakes" "nix-command" ];
      # Recommended when using `direnv` etc.
      keep-derivations = true;
      keep-outputs = true;
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
      trusted-users = [ "@wheel" ];
      warn-dirty = false;
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Install and setup ZSH to work with nix(-darwin) as well
  programs.zsh.enable = true;

  # Add shells installed by nix to /etc/shells file
  environment.shells = [ pkgs.zsh ];

  documentation.enable = false;
  documentation.man.enable = false;
}
