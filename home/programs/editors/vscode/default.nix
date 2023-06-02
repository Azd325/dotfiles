{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      bungcip.better-toml
      dracula-theme.theme-dracula
      editorconfig.editorconfig
      eamodio.gitlens
      github.copilot
      github.vscode-github-actions
      kahole.magit
      mechatroner.rainbow-csv
      ms-azuretools.vscode-docker
      ms-python.python
      ms-vscode.makefile-tools
      redhat.vscode-yaml
    ];
  };
}
