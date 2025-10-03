_: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      # FNM
      eval "$(fnm env --use-on-cd)"
    '';
  };
}
