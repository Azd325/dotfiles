{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
    extensions = [
      pkgs.gh-eco
      pkgs.gh-dash
      pkgs.gh-actions-cache
      pkgs.gh-cal
    ];
  };
}
