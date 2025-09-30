{ pkgs, ... }:
{
  home.packages = [
    pkgs.stylua
    pkgs.lua-language-server
    pkgs.python313Packages.python-lsp-server
    pkgs.nil
    pkgs.nixfmt-rfc-style
    pkgs.clojure-lsp
  ];

  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "lua";
          auto-format = true;
          formatter = {
            command = "${pkgs.stylua.out}/bin/stylua";
            args = [ "-" ];
          };
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs."nixfmt-rfc-style".out}/bin/nixfmt";
          };
        }
        {
          name = "clojure";
          auto-format = true;
          formatter = {
            # binary not managed by nix
            command = "cljfmt";
            args = [
              "fix"
              "-"
            ];
          };
        }
      ];
    };
    settings = {
      editor = {
        line-number = "relative";
      };
      theme = "rose_pine";
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
      };
    };
  };
}
