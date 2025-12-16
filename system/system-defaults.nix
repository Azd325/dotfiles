_: {
  # macOS system defaults and UI/UX preferences
  # Note: Some settings may require logout/login or app restart to take effect
  # Post-apply: Run `killall Dock && killall Finder` to apply Dock/Finder changes

  system = {
    defaults = {
      # Dock settings
      dock = {
        autohide = true; # Auto-hide dock for more screen space
        show-recents = false; # Don't show recent apps in Dock
        mru-spaces = false; # Don't rearrange spaces based on recent use
        tilesize = 48; # Smaller dock icons
      };

      finder = {
        ShowPathbar = true;
        # Show all file extensions in the Finder
        AppleShowAllExtensions = true;
        # Add a quit option to the Finder
        QuitMenuItem = true;
        # Choose whether to display a warning when changing a file extension
        FXEnableExtensionChangeWarning = false;
        # Whether to show external disks on desktop
        ShowExternalHardDrivesOnDesktop = false;
        # Keep folders on top when sorting by name
        _FXSortFoldersFirst = true;
        # When performing a search, search the current folder by default
        FXDefaultSearchScope = "SCcf";
        # Column view is superior for developers
        FXPreferredViewStyle = "clmv";
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

      # Choose the delay of the auto-hidden document-proxy icon
      # system.defaults.NSGlobalDomain.NSToolbarTitleViewRolloverDelay = 0;
      NSGlobalDomain = {
        NSTableViewDefaultSizeMode = 1;
        NSWindowShouldDragOnGesture = true;
        NSAutomaticWindowAnimationsEnabled = false;
        # Faster keyboard repeat rate - great for coding
        # Requires logout/login to take effect
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        # Tap to click trackpad
        "com.apple.mouse.tapBehavior" = 1;
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
