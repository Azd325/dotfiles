{
  config,
  lib,
  pkgs,
  ...
}:
let
  primaryUser = config.system.primaryUser or null;
  userHome = if primaryUser == null then null else "/Users/${primaryUser}";

  # Nix configuration file (shared across hosts)
  # Contains: access-tokens for GitHub, and potentially other Nix settings
  nixConfigFile = ../secrets/shared/default.yaml;

  # Activation scripts with automatic shellcheck at build time
  checkAgeKeyScript = pkgs.writeShellApplication {
    name = "check-sops-age-key";
    runtimeInputs = [ pkgs.gnugrep ];
    text = builtins.readFile ./scripts/check-age-key.sh;
  };

  validateNixConfigScript = pkgs.writeShellApplication {
    name = "validate-nix-config";
    runtimeInputs = [
      pkgs.gnugrep
      pkgs.coreutils
    ];
    text = builtins.readFile ./scripts/validate-nix-config.sh;
  };
in
lib.mkIf (userHome != null) {
  # Decrypt Nix configuration using sops
  sops.secrets.nix-config = lib.mkIf (builtins.pathExists nixConfigFile) {
    format = "yaml";
    key = "nix-config";
    sopsFile = nixConfigFile;
    mode = "0600";
  };

  # Validate age key and Nix configuration before activation
  # This ensures validation runs BEFORE Nix daemon loads the config
  system.activationScripts.preActivation.text =
    let
      hasNixConfig = config ? sops && config.sops ? secrets && config.sops.secrets ? nix-config;
    in
    lib.mkBefore (
      ''
        echo "Validating sops age key..."
        ${checkAgeKeyScript}/bin/check-sops-age-key "${primaryUser}"
      ''
      + lib.optionalString hasNixConfig ''
        echo "Validating Nix configuration format..."
        ${validateNixConfigScript}/bin/validate-nix-config "${config.sops.secrets.nix-config.path}"
      ''
    );
}
