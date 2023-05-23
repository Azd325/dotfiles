{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
      bungcip.better-toml
      editorconfig.editorconfig
      eamodio.gitlens
      github.copilot
      github.vscode-github-actions
      kahole.magit
      ms-azuretools.vscode-docker
      ms-python.python
      ms-vscode.makefile-tools
      mvllow.rose-pine
      redhat.vscode-yaml
    ];
    userSettings = {
      workbench = {
        colorTheme = "Rosé Pine";
        iconTheme = "rose-pine-icons";
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
