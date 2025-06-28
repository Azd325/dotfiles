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
      Infuse = 1136220934;
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
      "docker-desktop"
      "figma"
      "firefox"
      "font-geist-mono"
      "font-sf-mono"
      "gas-mask"
      "ghostty"
      "gpg-suite"
      "handbrake-app"
      "hot"
      "horos"
      "iina"
      "iterm2"
      "keka"
      "languagetool-desktop"
      "makemkv"
      "microsoft-auto-update"
      "microsoft-office"
      "microsoft-teams"
      "obsidian"
      "podman-desktop"
      "postgres-unofficial"
      "pycharm"
      "raycast"
      "session-manager-plugin"
      "stats"
      "tailscale-app"
      "telegram"
      "temurin@11"
      "thunderbird"
      "vlc"
      "utm"
      "zed"
    ];
  };

}
