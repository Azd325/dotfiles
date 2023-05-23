{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      bungcip.better-toml
      dracula-theme.theme-dracula
      editorconfig.editorconfig
      eamodio.gitlens
      github.copilot
      github.vscode-github-actions
      kahole.magit
      ms-azuretools.vscode-docker
      ms-python.python
      ms-vscode.makefile-tools
      redhat.vscode-yaml
    ];
    userSettings = {
      workbench = {
        colorTheme = "Dracula";
        tree = { indent = 20; };
      };
      editor = {
        inlineSuggest = { enabled = true; };
        fontFamily = "JetBrains Mono";
        fontSize = 15;
      };
      redhat = { telemetry = { enabled = false; }; };
    };
  };
}
