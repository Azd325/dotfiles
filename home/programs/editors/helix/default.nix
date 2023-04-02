{ pkgs, ... }: {
  home.packages = [
    pkgs.stylua
    pkgs.lua-language-server
    pkgs.python311Packages.python-lsp-server
    pkgs.python311Packages.black
    pkgs.nil
  ];

  programs.helix = {
    enable = true;
    languages = [
      {
        name = "lua";
        auto-format = true;
        formatter = {
          command = "${pkgs.stylua.out}/bin/stylua";
          args = [ "-" ];
        };
      }
      {
        name = "python";
        auto-format = true;
        formatter = {
          command = "${pkgs.python311Packages.black.out}/bin/black";
          args = [ "--quiet -" ];
        };
      }
    ];
    settings = {
      theme = "rose_pine";
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
      };
    };
  };
}
