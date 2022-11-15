{ pkgs, ... }:

{
  system = {
    defaults = {
      finder = {
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

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
}
