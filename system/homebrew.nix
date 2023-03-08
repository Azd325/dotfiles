{ ... }: {

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    onActivation.cleanup = "zap";
    global.brewfile = true;

    taps = [
      "AdoptOpenJDK/openjdk"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/core"
      "d12frosted/emacs-plus"
    ];

    # Prefer installing application from the Mac App Store
    masApps = {
      Enpass = 732710998;
      Keynote = 409183694;
      Numbers = 409203825;
      Pages = 409201541;
      TestFlight = 899247664;
      WireGuard = 1451685025;
      Xcode = 497799835;
    };

    # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
    # installed in `../home/default.nix` whenever possible.
    brews = [
      "coreutils"
      "gdal"
      "grep"
      "emacs-plus"
      "magic-wormhole"
      "pango"
      "pyenv"
      "fnm"
      "rabbitmq"
      "rbenv"
    ];

    # If an app isn't available in the Mac App Store, or the version in the App Store has
    # limitiations, e.g., Transmit, install the Homebrew Cask.
    casks = [
      # "adobe-digital-editions" # rosetta missing
      "adoptopenjdk11"
      "android-studio"
      "app-tamer"
      "appcleaner"
      "arc"
      "balenaetcher"
      "calibre"
      "coconutbattery"
      "daisydisk"
      "docker"
      "firefox"
      "garmin-express"
      "gas-mask"
      "google-chrome"
      "gpg-suite"
      "hot"
      "istat-menus"
      "iterm2"
      "keka"
      "libreoffice"
      "logseq"
      "lulu"
      "micro-snitch"
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
  };

}
