{ config, pkgs, ... }:

{
  # https://github.com/LnL7/nix-darwin/issues/477
  users.users.timkleinschmidt = {
    name = "timkleinschmidt";
    home = "/Users/timkleinschmidt";
    description = "timkleinschmidt";
  };
  nix.configureBuildUsers = true;
  system = {
    defaults = {
      finder = {
        # Show all file extensions in the Finder.
        AppleShowAllExtensions = true;
        # Add a quit option to the Finder.
        QuitMenuItem = true;
        # Choose whether to display a warning when changing a file extension.
        FXEnableExtensionChangeWarning = false;
      };

      screencapture.location = "~/Downloads/";

      # Choose the delay of the auto-hidden document-proxy icon.
      #system.defaults.NSGlobalDomain.NSToolbarTitleViewRolloverDelay = 0;
      NSGlobalDomain.NSTableViewDefaultSizeMode = 1;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  homebrew = {
    enable = true;
    global = {
      brewfile = true;
      lockfiles = true;
    };
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
    };
    taps = [
      "AdoptOpenJDK/openjdk"
      "d12frosted/emacs-plus"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/core"
    ];
    masApps = { Enpass = 732710998; };
    brews = [ "coreutils" "emacs-plus" "gdal" "grep" "rabbitmq" "pyenv" ];
    casks = [
      "adobe-digital-editions"
      "adoptopenjdk11"
      "appcleaner"
      "app-tamer"
      "calibre"
      "coconutbattery"
      "daisydisk"
      "docker"
      "garmin-express"
      "gas-mask"
      "google-chrome"
      "gpg-suite"
      "istat-menus"
      "iterm2"
      "keka"
      "libreoffice"
      "logseq"
      "microsoft-auto-update"
      "microsoft-office"
      "microsoft-teams"
      "moneymoney"
      "postgres-unofficial"
      "postico"
      "pycharm-ce"
      "telegram"
      "tunnelblick"
      "warp"
      "zotero"
    ];
  };

  nix.gc.automatic = true;

  nix.settings = {
    sandbox = true;
    substituters = [ "https://cache.nixos.org/" ];
    trusted-public-keys =
      [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  };

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    max-jobs = auto  # Allow building multiple derivations in parallel
  '';

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
