_: {
  home.file = {
    ".config/doom".source = ./doom-emacs;
    ".shadow-cljs".source = ./shadow-cljs;
    ".yarnrc.yml".source = ./.yarnrc.yml;
    ".zprofile".source = ./.zprofile;
    ".gemini/settings.json".source = ./.gemini/settings.json;
    ".gemrc".text = "gem: --no-document";
    ".config/nix/nix.conf".text = ''
      !include /run/secrets/nix-config
    '';
  };
}
