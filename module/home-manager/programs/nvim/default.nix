{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      rose-pine
      trouble-nvim
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-lua
          tree-sitter-toml
          tree-sitter-python
          tree-sitter-nix
          tree-sitter-markdown
          tree-sitter-bash
          tree-sitter-css
          tree-sitter-html
          tree-sitter-json
          tree-sitter-vim
        ]
      ))
      nvim-treesitter-context
      harpoon
      lsp-zero-nvim
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
