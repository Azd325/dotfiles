_:
{
  programs.kitty = {
    enable = true;

    settings = {
      # Font rendering
      disable_ligatures = "always"; # Disabled per preference

      # Window layout
      window_padding_width = 4;

      # Tab bar
      tab_bar_style = "powerline";
      tab_bar_edge = "top";

      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";

      # Scrollback
      scrollback_lines = 10000;

      # Bell
      enable_audio_bell = false;
      visual_bell_duration = 0;

      # Mouse
      copy_on_select = true; # Enabled per preference

      # Shell integration
      shell_integration = "no-rc"; # Disabled automatic RC to avoid conflicts

      # macOS specific
      macos_option_as_alt = "yes";
      macos_quit_when_last_window_closed = true;
      hide_window_decorations = "titlebar-only";
    };

    keybindings = {
      # Tab management
      "cmd+t" = "new_tab";
      "cmd+w" = "close_tab";

      # Tab navigation - keyboard-layout-agnostic shortcuts
      # Direct tab access (works on all keyboard layouts)
      "cmd+1" = "goto_tab 1";
      "cmd+2" = "goto_tab 2";
      "cmd+3" = "goto_tab 3";
      "cmd+4" = "goto_tab 4";
      "cmd+5" = "goto_tab 5";
      "cmd+6" = "goto_tab 6";
      "cmd+7" = "goto_tab 7";
      "cmd+8" = "goto_tab 8";
      "cmd+9" = "goto_tab 9";

      # Next/previous tab (universal shortcuts that work across layouts)
      "ctrl+tab" = "next_tab";
      "ctrl+shift+tab" = "previous_tab";
      "cmd+shift+right" = "next_tab";
      "cmd+shift+left" = "previous_tab";

      # Keep US keyboard shortcuts for compatibility
      "cmd+shift+]" = "next_tab";
      "cmd+shift+[" = "previous_tab";

      # Font size
      "cmd+plus" = "change_font_size all +1.0";
      "cmd+minus" = "change_font_size all -1.0";
      "cmd+0" = "change_font_size all 0";
    };
  };
}
