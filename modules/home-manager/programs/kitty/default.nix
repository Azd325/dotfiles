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
      "cmd+t" = "new_tab";
      "cmd+w" = "close_tab";
      "cmd+shift+]" = "next_tab";
      "cmd+shift+[" = "previous_tab";
      "cmd+plus" = "change_font_size all +1.0";
      "cmd+minus" = "change_font_size all -1.0";
      "cmd+0" = "change_font_size all 0";
    };
  };
}
