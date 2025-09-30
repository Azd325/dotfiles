{ ... }: {
  imports = [ ./helix ./nvim ./vscode ];
  # programs.emacs = { enable = true; };

  programs."zed-editor" = {
    enable = true;
    extensions = ["nix" "toml" "make"];
  };
}
