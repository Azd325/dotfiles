{ ... }: {

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    onActivation.cleanup = "zap";
    global.brewfile = true;

    taps = [
      "homebrew/cask-versions"
      "d12frosted/emacs-plus"
      "pulumi/tap"
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
      "Structured - Tagesplaner" = 1499198946;
    };

    brews = [
      "awscli"
      "coreutils"
      "gdal"
      "grep"
      "emacs-plus"
      "magic-wormhole"
      "pango"
      "pulumi"
      "pyenv"
      "fnm"
      "rabbitmq"
      "rbenv"
    ];

    casks = [
      "adobe-digital-editions"
      "android-studio"
      "arc"
      "calibre"
      "coconutbattery"
      "daisydisk"
      "discord"
      "docker"
      "figma"
      "firefox"
      "garmin-express"
      "gas-mask"
      "google-chrome"
      "gpg-suite"
      "hot"
      "istat-menus"
      "iterm2"
      "keka"
      "languagetool"
      "logseq"
      "microsoft-auto-update"
      "microsoft-edge"
      "microsoft-office"
      "microsoft-teams"
      "pika"
      "portfolioperformance"
      "postgres-unofficial"
      "postico"
      "pycharm-ce"
      "raycast"
      "telegram"
      "temurin11"
      "tunnelblick"
      "utm"
    ];
  };

}
