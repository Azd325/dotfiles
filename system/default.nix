{ pkgs, ... }: {

  imports = [ ./homebrew.nix ];

  networking.computerName = "Tim’s 💻";
  networking.hostName = "BER";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    configureBuildUsers = true;
    package = pkgs.nix;
    settings = {
      trusted-users = [ "@admin" ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      # Recommended when using `direnv` etc.
      keep-derivations = true;
      keep-outputs = true;
    };
  };

  # Add shells installed by nix to /etc/shells file
  environment.shells = [ pkgs.zsh ];

  # Install and setup ZSH to work with nix(-darwin) as well
  programs.zsh.enable = true;

  documentation.enable = false;
  documentation.man.enable = false;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;

    defaults = {
      finder = {
        ShowPathbar = true;
        # Show all file extensions in the Finder.
        AppleShowAllExtensions = true;
        # Add a quit option to the Finder.
        QuitMenuItem = true;
        # Choose whether to display a warning when changing a file extension.
        FXEnableExtensionChangeWarning = false;
      };

      screencapture.location = "~/Downloads/";

      # Choose the delay of the auto-hidden document-proxy icon.
      #system.defaults.NSGlobalDomain.NSToolbarTitleViewRolloverDelay = 0;
      NSGlobalDomain.NSTableViewDefaultSizeMode = 1;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  users.users.timkleinschmidt = {
    name = "timkleinschmidt";
    home = "/Users/timkleinschmidt";
  };
}
