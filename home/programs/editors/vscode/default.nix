{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      editorconfig.editorconfig
      ms-azuretools.vscode-docker
      ms-python.python
    ];
  };
}
