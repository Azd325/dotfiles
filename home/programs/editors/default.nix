{ ... }: {
  imports = [ ./helix ./vscode ];
  # programs.emacs = { enable = true; };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
