{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
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
      oderwat.indent-rainbow
      redhat.vscode-yaml
    ];
    userSettings = {
      workbench = {
        colorTheme = "Rosé Pine";
        iconTheme = "rose-pine-icons";
      };
      editor = { inlineSuggest = { enabled = true; }; };
      redhat = { telemetry = { enabled = false; }; };
    };
  };
}
