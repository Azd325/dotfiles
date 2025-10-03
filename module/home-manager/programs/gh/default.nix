{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
    extensions = with pkgs; [
      gh-eco
      gh-dash
      gh-actions-cache
      gh-cal
    ];
  };
}
