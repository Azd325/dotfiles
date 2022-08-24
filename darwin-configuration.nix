{ config, pkgs, ... }:

{
  nix.binaryCaches = [ "https://cache.nixos.org/" ];
  nix.binaryCachePublicKeys =
    [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  # https://github.com/LnL7/nix-darwin/issues/477
  users.users.timkleinschmidt = {
    name = "timkleinschmidt";
    home = "/Users/timkleinschmidt";
    description = "timkleinschmidt";
  };
  users.nix.configureBuildUsers = true;
  # Show all file extensions in the Finder.
  system.defaults.finder.AppleShowAllExtensions = true;
  # Add a quit option to the Finder.
  system.defaults.finder.QuitMenuItem = true;
  # Choose whether to display a warning when changing a file extension.
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  # Choose the delay of the auto-hidden document-proxy icon.
  #system.defaults.NSGlobalDomain.NSToolbarTitleViewRolloverDelay = 0;
  system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 1;

  system.keyboard.enableKeyMapping = true;

  system.keyboard.remapCapsLockToEscape = true;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      fira-code
      fira-code-symbols
      jetbrains-mono
      source-code-pro
    ];
  };

  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "AdoptOpenJDK/openjdk"
    "d12frosted/emacs-plus"
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/core"
  ];
  homebrew.masApps = { Enpass = 732710998; };
  homebrew.brews =
    [ "coreutils" "emacs-plus" "gdal" "grep" "rabbitmq" "pyenv" ];
  homebrew.casks = [
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
    "portfolioperformance"
    "postgres-unofficial"
    "postico"
    "pycharm-ce"
    "telegram"
    "tunnelblick"
    "visual-studio-code"
    "zotero"
  ];

  nix.gc.automatic = true;

  # Sandbox causes failure: https://github.com/NixOS/nix/issues/4119
  nix.useSandbox = false;

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
