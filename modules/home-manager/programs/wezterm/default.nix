_:
{
  programs.wezterm = {
    enable = true;

    # Comfortable font size for typical DPI setups
    extraConfig = ''
      return {
        font_size = 15.0,
        line_height = 1.05,
        cell_width = 0.98,
        harfbuzz_features = {
          "liga=0",
          "clig=0",
          "calt=0",
        },
        front_end = "WebGpu",
      }
    '';
  };
}
