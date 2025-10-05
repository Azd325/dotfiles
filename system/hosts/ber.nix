{ username, ... }:
{
  networking = {
    computerName = "Tim’s 💻";
    hostName = "BER";
  };

  # Enable TouchID authentication for sudo.
  security.pam.services.sudo_local.touchIdAuth = true;

  services.aerospace = {
    enable = true;
    settings = {
      accordion-padding = 12;
      gaps = {
        outer = {
          top = 8;
          bottom = 8;
          left = 8;
          right = 8;
        };
        inner = {
          horizontal = 6;
          vertical = 6;
        };
      };
      mode = {
        main = {
          binding = {
            # Disable macOS hide shortcuts
            "cmd-h" = [ ];
            "cmd-alt-h" = [ ];

            # Toggle fullscreen
            "alt-f" = "fullscreen";

            # See: https://nikitabobko.github.io/AeroSpace/commands#layout
            "alt-period" = "layout tiles horizontal vertical";
            "alt-comma" = "layout accordion horizontal vertical";

            # See: https://nikitabobko.github.io/AeroSpace/commands#focus
            "alt-left" = "focus left";
            "alt-down" = "focus down";
            "alt-up" = "focus up";
            "alt-right" = "focus right";
            # Vim-style equivalents
            "alt-h" = "focus left";
            "alt-j" = "focus down";
            "alt-k" = "focus up";
            "alt-l" = "focus right";

            # See: https://nikitabobko.github.io/AeroSpace/commands#move
            "alt-shift-left" = "move left";
            "alt-shift-down" = "move down";
            "alt-shift-up" = "move up";
            "alt-shift-right" = "move right";

            # See: https://nikitabobko.github.io/AeroSpace/commands#resize
            "alt-shift-minus" = "resize smart -50";
            "alt-shift-equal" = "resize smart +50";
            "alt-shift-c" = "reload-config";

            # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
            "alt-1" = "workspace 1";
            "alt-2" = "workspace 2";
            "alt-3" = "workspace 3";
            "alt-4" = "workspace 4";
            "alt-5" = "workspace 5";
            "alt-6" = "workspace 6";
            "alt-7" = "workspace 7";
            "alt-8" = "workspace 8";
            "alt-9" = "workspace 9";

            # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
            "alt-shift-1" = "move-node-to-workspace 1";
            "alt-shift-2" = "move-node-to-workspace 2";
            "alt-shift-3" = "move-node-to-workspace 3";
            "alt-shift-4" = "move-node-to-workspace 4";
            "alt-shift-5" = "move-node-to-workspace 5";
            "alt-shift-6" = "move-node-to-workspace 6";
            "alt-shift-7" = "move-node-to-workspace 7";
            "alt-shift-8" = "move-node-to-workspace 8";
            "alt-shift-9" = "move-node-to-workspace 9";

            # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
            "alt-tab" = "workspace-back-and-forth";

            # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
            "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";
          };
        };
        service = {
          binding = {
            # Reset or escape from service mode
            esc = [
              "reload-config"
              "mode main"
            ];
            r = [
              "flatten-workspace-tree"
              "mode main"
            ];
            f = [
              "layout floating tiling"
              "mode main"
            ];
            backspace = [
              "close-all-windows-but-current"
              "mode main"
            ];

            # Container join helpers
            "alt-shift-h" = [
              "join-with left"
              "mode main"
            ];
            "alt-shift-j" = [
              "join-with down"
              "mode main"
            ];
            "alt-shift-k" = [
              "join-with up"
              "mode main"
            ];
            "alt-shift-l" = [
              "join-with right"
              "mode main"
            ];

            # Volume controls
            down = "volume down";
            up = "volume up";
            "shift-down" = [
              "volume set 0"
              "mode main"
            ];
          };
        };
      };
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      on-focus-changed = [ "move-mouse window-lazy-center" ];
      on-window-detected = [
        # Auto-place select apps on launch
        {
          "if" = {
            "app-id" = "ru.keepcoder.Telegram";
          };
          run = "move-node-to-workspace 4";
        }
        {
          "if" = {
            "app-id" = "company.thebrowser.Browser";
          };
          run = "move-node-to-workspace 2";
        }
        {
          "if" = {
            "app-id" = "app.zen-browser.zen";
          };
          run = "move-node-to-workspace 2";
        }
        {
          "if" = {
            "app-id" = "org.mozilla.firefox";
          };
          run = "move-node-to-workspace 2";
        }
        {
          "if" = {
            "app-id" = "com.googlecode.iterm2";
          };
          run = "move-node-to-workspace 1";
        }
        {
          "if" = {
            "app-id" = "com.mitchellh.ghostty";
          };
          run = "move-node-to-workspace 1";
        }
        {
          "if" = {
            "app-id" = "com.jetbrains.pycharm";
          };
          run = "move-node-to-workspace 3";
        }
        {
          "if" = {
            "app-id" = "com.microsoft.VSCode";
          };
          run = "move-node-to-workspace 3";
        }
        {
          "if" = {
            "app-id" = "org.gnu.Emacs";
          };
          run = "move-node-to-workspace 3";
        }
      ];
      after-startup-command = [
        "exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=5.0"
      ];
    };
  };

  services.jankyborders = {
    enable = true;
    active_color = "0xffe1e3e4";
    inactive_color = "0xff494d64";
    width = 5.0;
  };

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
