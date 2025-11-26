{
  pkgs,
  config,
  ...
}:
{
  nix = {
    enable = true;
    channel.enable = false;
    extraOptions = "!include ${config.sops.secrets.github-token.path}";
    settings = {
      # https://github.com/NixOS/nix/issues/7273
      auto-optimise-store = false;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      # Recommended when using `direnv` etc.
      keep-derivations = true;
      keep-outputs = true;
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
        "https://numtide.cachix.org"
      ];
      trusted-users = [
        config.system.primaryUser
        "root"
        "@wheel"
        "@admin"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
      warn-dirty = false;
    };
  };

  ids.gids.nixbld = 350;

  nixpkgs.config.allowUnfree = true;

  # Install and setup ZSH to work with nix(-darwin) as well
  programs.zsh.enable = true;

  # Add shells installed by nix to /etc/shells file
  environment.shells = [ pkgs.zsh ];

  documentation.enable = false;
  documentation.man.enable = false;
}
