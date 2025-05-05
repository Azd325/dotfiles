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
      "coreutils"
      "emacs-plus"
      "fnm"
      "gdal"
      "gitu"
      "grep"
      "magic-wormhole"
      "pango"
      "podman"
      "pulumi"
      "pyenv"
      "rbenv"
    ];

    casks = [
      "adobe-digital-editions"
      "android-studio"
      "pearcleaner"
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
      "ghostty"
      "gpg-suite"
      "handbrake"
      "hot"
      "iina"
      "iterm2"
      "keka"
      "languagetool"
      "makemkv"
      "microsoft-auto-update"
      "microsoft-edge"
      "microsoft-office"
      "microsoft-teams"
      "obsidian"
      "pika"
      "podman-desktop"
      "postgres-unofficial"
      "pycharm"
      "raycast"
      "session-manager-plugin"
      "stats"
      "telegram"
      "temurin@11"
      "vlc"
      "utm"
      "zed"
    ];
  };

}
