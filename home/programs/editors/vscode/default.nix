{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      editorconfig.editorconfig
      eamodio.gitlens
      github.copilot
      github.vscode-github-actions
      kahole.magit
      ms-azuretools.vscode-docker
      ms-python.python
      ms-vscode.makefile-tools
      mvllow.rose-pine
      oderwat.indent-rainbow
    ];
    userSettings = {
      workbench = {
        colorTheme = "Rosé Pine";
        iconTheme = "rose-pine-icons";
      };
      editor = { inlineSuggest = { enabled = true; }; };
    };
  };
}
