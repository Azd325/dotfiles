{ config, lib, ... }:

let
  inherit (lib) mkIf;
  caskPresent = cask: lib.any (x: x.name == cask) config.homebrew.casks;
  brewEnabled = config.homebrew.enable;

in {
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;

  homebrew.taps = [
    "AdoptOpenJDK/openjdk"
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/core"
    "d12frosted/emacs-plus"
  ];

  # Prefer installing application from the Mac App Store
  homebrew.masApps = {
    Enpass = 732710998;
    Keynote = 409183694;
    Numbers = 409203825;
    Pages = 409201541;
    WireGuard = 1451685025;
    Xcode = 497799835;
  };

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
  homebrew.brews =
    [ "coreutils" "emacs-plus" "gdal" "grep" "rabbitmq" "pyenv" ];

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "adobe-digital-editions"
    "adoptopenjdk11"
    "app-tamer"
    "appcleaner"
    "balenaetcher"
    "calibre"
    "coconutbattery"
    "daisydisk"
    "firefox"
    "garmin-express"
    "gas-mask"
    "google-chrome"
    "gpg-suite"
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
    "wow"
    "zotero"
  ];
}
