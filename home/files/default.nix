{ rose-pine-warp, ... }: {
  home.file.".config/doom" = { source = ./doom-emacs; };
  home.file.".shadow-cljs" = { source = ./shadow-cljs; };
  home.file.".yarnrc.yml" = { source = ./.yarnrc.yml; };
  home.file.".zprofile" = { source = ./.zprofile; };
  home.file.".warp/themes/rose-pine-warp" = { source = rose-pine-warp; };
  home.file.".gemrc".text = "gem: --no-document";
}
