{ config, lib, ... }:
let
  primaryUser = config.system.primaryUser or null;
  userHome = if primaryUser == null then null else "/Users/${primaryUser}";
in
lib.mkIf (userHome != null) {
  sops.age = {
    keyFile = "${userHome}/.config/sops/age/keys.txt";
    sshKeyPaths = [ ];
    generateKey = false;
  };
}
