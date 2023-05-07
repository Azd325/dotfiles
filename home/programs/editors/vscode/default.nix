{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      editorconfig.editorconfig
      github.copilot
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
