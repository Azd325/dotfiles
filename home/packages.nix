{ lib, pkgs }:

let
  packages = lib.attrValues ({
    inherit (pkgs) cachix niv nixfmt nixpkgs-review;

    inherit (pkgs)
      coreutils curl direnv docker duf editorconfig-core-c fd fzf fnm gh ripgrep
      rsync shellcheck shfmt tmux vim wget youtube-dl wireguard-tools gnupg;

    # git
    inherit (pkgs.gitAndTools) git-absorb;

    # fonts
    inherit (pkgs) fira-code fira-code-symbols jetbrains-mono source-code-pro;

    inherit (pkgs) discord;
  });
in packages
