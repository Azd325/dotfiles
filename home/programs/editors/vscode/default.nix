{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      editorconfig.editorconfig
      kahole.magit
      ms-azuretools.vscode-docker
      ms-python.python
      ms-vscode.makefile-tools
      oderwat.indent-rainbow
    ];
  };
}
