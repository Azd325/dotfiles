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

    brews = [
      "backlog-md"
      "emacs-plus"
      "fnm"
      "gdal"
      "gitu"
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
