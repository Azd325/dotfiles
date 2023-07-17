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

    masApps = {
      Endel = 1346247457;
      Enpass = 732710998;
      Keynote = 409183694;
      Numbers = 409203825;
      Pages = 409201541;
      #TestFlight = 899247664;
      WireGuard = 1451685025;
      Xcode = 497799835;
    };

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

    casks = [
      "adobe-digital-editions"
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
      "epic-games"
      "firefox"
      "garmin-express"
      "gas-mask"
      "google-chrome"
      "gpg-suite"
      "hot"
      "istat-menus"
      "iterm2"
      "keka"
      "keybase"
      "libreoffice"
      "logseq"
      "lulu"
      "micro-snitch"
      "microsoft-auto-update"
      "microsoft-edge"
      "microsoft-office"
      "microsoft-teams"
      "moneymoney"
      "pika"
      "postgres-unofficial"
      "postico"
      "pycharm-ce"
      "raycast"
      "signal"
      "steam"
      "utm"
      "telegram"
      "tunnelblick"
      "warp"
      "wow"
    ];
  };

}
