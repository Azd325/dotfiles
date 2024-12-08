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
      Enpass = 732710998;
      TestFlight = 899247664;
      WireGuard = 1451685025;
      Xcode = 497799835;
    };

    brews = [
      "awscli"
      "coreutils"
      "gdal"
      "grep"
      "gitu"
      "emacs-plus"
      "magic-wormhole"
      "pango"
      "pulumi"
      "pyenv"
      "fnm"
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
      "font-geist-mono"
      "font-sf-mono"
      "gas-mask"
      "gpg-suite"
      "hot"
      "iina"
      "iterm2"
      "keka"
      "languagetool"
      "logseq"
      "microsoft-auto-update"
      "microsoft-edge"
      "microsoft-office"
      "microsoft-teams"
      "pika"
      "postgres-unofficial"
      "postico"
      "pycharm-ce"
      "raycast"
      "session-manager-plugin"
      "stats"
      "telegram"
      "temurin@11"
      "utm"
      "zed"
    ];
  };

}
