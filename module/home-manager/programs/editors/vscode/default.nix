{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      charliermarsh.ruff
      dracula-theme.theme-dracula
      eamodio.gitlens
      editorconfig.editorconfig
      esbenp.prettier-vscode
      github.copilot
      github.vscode-github-actions
      github.vscode-pull-request-github
      kahole.magit
      mechatroner.rainbow-csv
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      ms-vscode.makefile-tools
      redhat.vscode-yaml
      tamasfe.even-better-toml
    ];
  };
}
