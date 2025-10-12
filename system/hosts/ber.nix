{ username, ... }:
{
  networking = {
    computerName = "Tim’s 💻";
    hostName = "BER";
  };

  # Enable TouchID authentication for sudo.
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;

    primaryUser = username;

    defaults = {
      finder = {
        ShowPathbar = true;
        # Show all file extensions in the Finder.
        AppleShowAllExtensions = true;
        # Add a quit option to the Finder.
        QuitMenuItem = true;
        # Choose whether to display a warning when changing a file extension.
        FXEnableExtensionChangeWarning = false;
        # Whether to show external disks on desktop.
        ShowExternalHardDrivesOnDesktop = false;
        # Keep folders on top when sorting by name.
        _FXSortFoldersFirst = true;
        # When performing a search, search the current folder by default
        FXDefaultSearchScope = "SCcf";
      };

      menuExtraClock = {
        # Show a 24-hour clock
        Show24Hour = true;
        # Show the date when space is available
        ShowDate = 2;
        # Hide the seconds
        ShowSeconds = false;
      };

      screencapture = {
        location = "~/Downloads/";
        show-thumbnail = false;
      };

      screensaver.askForPassword = true;

      # Choose the delay of the auto-hidden document-proxy icon.
      # system.defaults.NSGlobalDomain.NSToolbarTitleViewRolloverDelay = 0;
      NSGlobalDomain = {
        NSTableViewDefaultSizeMode = 1;
        NSWindowShouldDragOnGesture = true;
        NSAutomaticWindowAnimationsEnabled = false;
      };

      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
