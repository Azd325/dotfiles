{ config, ... }:
{

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    global.brewfile = true;
    taps = builtins.attrNames config.nix-homebrew.taps;

    masApps = {
      Enpass = 732710998;
      Infuse = 1136220934;
      TestFlight = 899247664;
      WireGuard = 1451685025;
      Xcode = 497799835;
    };

    brews = [
      "backlog-md"
      "coreutils"
      "emacs-plus"
      "fnm"
      "gdal"
      "gitu"
      "grep"
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
      "google-chrome"
      "grandperspective"
      "handbrake-app"
      "hot"
      "horos"
      "iina"
      "iterm2"
      "jdownloader"
      "keka"
      "kiro"
      "languagetool-desktop"
      "logseq"
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
