{ inputs
, username
,
}: system:
let
  system-config = import ../module/configuration.nix;
  home-manager-config = import ../module/home-manager;
  extraArgs = {
    inherit (inputs) alacritty-dracula-theme;
  };
in
inputs.darwin.lib.darwinSystem {
  inherit system;
  modules = [
    {
      imports = [ ./homebrew.nix ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      users.users.${username}.home = "/Users/${username}";

      networking.computerName = "Tim’s 💻";
      networking.hostName = "BER";

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

    }
    system-config

    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users."${username}" = home-manager-config;
      home-manager.extraSpecialArgs = extraArgs;
    }
  ];
}
