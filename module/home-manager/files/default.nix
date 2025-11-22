_: {
  home.file = {
    ".config/doom".source = ./doom-emacs;
    ".shadow-cljs".source = ./shadow-cljs;
    ".yarnrc.yml".source = ./.yarnrc.yml;
    ".zprofile".source = ./.zprofile;
    ".config/opencode/opencode.json".source = ./opencode.json;
    ".gemrc".text = "gem: --no-document";
  };
}
