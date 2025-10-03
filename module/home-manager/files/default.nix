_: {
  home.file = {
    ".config/doom".source = ./doom-emacs;
    ".shadow-cljs".source = ./shadow-cljs;
    ".yarnrc.yml".source = ./.yarnrc.yml;
    ".zprofile".source = ./.zprofile;
    ".gemrc".text = "gem: --no-document";
  };
}
