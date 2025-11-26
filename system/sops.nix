{ config, lib, ... }:
let
  primaryUser = config.system.primaryUser or null;
  userHome = if primaryUser == null then null else "/Users/${primaryUser}";
  exampleSecret = ../secrets/shared/default.yaml;
in
lib.mkIf (userHome != null) {
  sops = {
    age = {
      keyFile = "${userHome}/.config/sops/age/keys.txt";
      sshKeyPaths = [ ];
      generateKey = false;
    };
    secrets = lib.mkIf (builtins.pathExists exampleSecret) {
      github-token = {
        sopsFile = exampleSecret;
        format = "yaml";
        key = "github-token";
      };
    };
  };
}
