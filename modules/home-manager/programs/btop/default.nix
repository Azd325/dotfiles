_: {
  programs.btop = {
    enable = true;
    settings = {
      # Theme automatically applied by Stylix
      theme_background = false;

      # Display settings
      vim_keys = true;
      rounded_corners = true;
      graph_symbol = "braille";

      # Update intervals
      update_ms = 2000;

      # Process sorting
      proc_sorting = "cpu lazy";
      proc_tree = false;
      proc_per_core = false;

      # Show program path (similar to htop setting)
      show_program_path = true;
    };
  };
}
