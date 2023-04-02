{ ... }: {
  imports = [ ./nvim ./vscode ];
  # programs.emacs = { enable = true; };

  programs.helix = {
    enable = true;
    settings = {
      theme = "nord";
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
      };
    };
  };
}
