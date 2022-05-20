{ config, pkgs, ... }:

{
  # Show all file extensions in the Finder.
  system.defaults.finder.AppleShowAllExtensions = true;
  # Add a quit option to the Finder.
  system.defaults.finder.QuitMenuItem = true;
  # Choose whether to display a warning when changing a file extension.
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  # Choose the delay of the auto-hidden document-proxy icon.
  #system.defaults.NSGlobalDomain.NSToolbarTitleViewRolloverDelay = 0;
  system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 1;

  users.nix.configureBuildUsers = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    #yarn
    boot
    chezmoi
    coreutils
    direnv
    duf
    editorconfig-core-c
    exiftool
    fd
    ffmpeg
    fzf
    gifsicle
    gitAndTools.delta
    gitAndTools.gh
    gitAndTools.git-absorb
    gitAndTools.gitFull
    graphviz
    htop
    #magic-wormhole
    nixfmt
    nixpkgs-review
    pandoc
    php74
    qrencode
    ripgrep
    rsync
    shellcheck
    shfmt
    tmux
    vagrant
    vim
    wakatime
    youtube-dl
    zbar
    zsh
  ];

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      fira-code
      fira-code-symbols
      jetbrains-mono
      source-code-pro
    ];
  };

  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "AdoptOpenJDK/openjdk"
    "d12frosted/emacs-plus"
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/core"
  ];
  homebrew.masApps = { Enpass = 732710998; };
  homebrew.brews =
    [ "coreutils" "emacs-plus" "gdal" "grep" "fnm" "rabbitmq" "pyenv" ];
  homebrew.casks = [
    "adobe-digital-editions"
    "android-studio"
    "adoptopenjdk11"
    "adoptopenjdk8"
    "appcleaner"
    "app-tamer"
    "brave-browser"
    "calibre"
    "coconutbattery"
    "daisydisk"
    "docker"
    #"firefox"
    "garmin-express"
    "gas-mask"
    #"google-backup-and-sync"
    "google-chrome"
    "gpg-suite"
    "istat-menus"
    "iterm2"
    "keka"
    "libreoffice"
    "logseq"
    "microsoft-auto-update"
    "microsoft-office"
    "moneymoney"
    "portfolioperformance"
    "postgres"
    "postico"
    "pycharm-ce"
    "spotify"
    "teamviewer"
    "telegram"
    "tunnelblick"
    "virtualbox"
    "virtualbox-extension-pack"
    "visual-studio-code"
    "zotero"
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
