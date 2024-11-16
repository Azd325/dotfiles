{ ... }: {

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    onActivation.cleanup = "zap";
    global.brewfile = true;

    taps = [
      "homebrew/cask-versions"
    ];

    masApps = {
      Xcode = 497799835;
    };

    brews = [
      "coreutils"
      "grep"
    ];

    casks = [
      "iterm2"
    ];
  };

}
