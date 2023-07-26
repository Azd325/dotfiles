{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      charliermarsh.ruff
      eamodio.gitlens
      editorconfig.editorconfig
      github.copilot
      github.vscode-github-actions
      kahole.magit
      mechatroner.rainbow-csv
      ms-azuretools.vscode-docker
      ms-python.python
      ms-vscode.makefile-tools
      redhat.vscode-yaml
      tamasfe.even-better-toml
    ];
  };
}
