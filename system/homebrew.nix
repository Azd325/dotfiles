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
      "aichat"
      "codex"
      "coreutils"
      "emacs-plus"
      "fnm"
      "gdal"
      "gitu"
      "grep"
      "magic-wormhole"
      "pango"
      "podman"
      "postgresql"
      "pulumi"
      "rbenv"
    ];

    casks = [
      "adobe-digital-editions"
      "android-studio"
      "pearcleaner"
      "arc"
      "calibre"
      "chatgpt"
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
      "jdownloader"
      "keka"
      "kiro"
      "languagetool-desktop"
      "makemkv"
      "microsoft-auto-update"
      "microsoft-office"
      "microsoft-teams"
      "obsidian"
      "podman-desktop"
      "pycharm"
      "raycast"
      "session-manager-plugin"
      "sparrow"
      "stats"
      "tailscale-app"
      "telegram"
      "temurin@11"
      "thunderbird"
      "visual-studio-code"
      "vlc"
      "utm"
      "zed"
    ];
  };

}
