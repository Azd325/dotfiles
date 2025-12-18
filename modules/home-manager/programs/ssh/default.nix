{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  # Get hostname from Darwin system config, normalize to lowercase for file path
  hostname = lib.toLower osConfig.networking.hostName;
  sshHostsFile = ../../../../secrets/hosts/${hostname}/ssh-hosts.yaml;

  # Activation scripts with automatic shellcheck at build time
  checkAgeKeyScript = pkgs.writeShellApplication {
    name = "check-age-key";
    text = builtins.readFile ./scripts/check-age-key.sh;
  };

  validateSshConfigScript = pkgs.writeShellApplication {
    name = "validate-ssh-config";
    text = builtins.readFile ./scripts/validate-ssh-config.sh;
  };
in
{
  # SSH client configuration
  programs.ssh = {
    enable = true;
    # Disable default config values to avoid future deprecation issues
    # We explicitly set all values we need in matchBlocks."*"
    enableDefaultConfig = false;

    extraConfig = ''
      IgnoreUnknown UseKeychain
      UseKeychain yes
      IdentitiesOnly yes

      ${lib.optionalString (builtins.pathExists sshHostsFile) ''
        # Include SSH host configurations (decrypted by sops-nix)
        # This file is managed by sops and contains encrypted SSH host definitions
        Include ~/.ssh/config.d/hosts
      ''}
    '';

    matchBlocks = {
      "*" = {
        # Add keys to SSH agent automatically
        addKeysToAgent = "yes";
        # Disable agent forwarding by default (security best practice)
        forwardAgent = false;
        # Prefer modern key types, fallback to RSA for compatibility
        identityFile = [
          "~/.ssh/id_ed25519"
          "~/.ssh/id_rsa"
        ];
      };
    };
  };

  # Decrypt SSH hosts configuration using sops
  sops.secrets.ssh-hosts = lib.mkIf (builtins.pathExists sshHostsFile) {
    format = "yaml";
    key = "ssh-config"; # Extract the 'ssh-config' key from the YAML
    sopsFile = sshHostsFile;
    # Create symlink at ~/.ssh/config.d/hosts
    path = "${config.home.homeDirectory}/.ssh/config.d/hosts";
    mode = "0600"; # Explicit permissions required by SSH
  };

  # Combine all home-manager configuration attributes to avoid statix W20 warning
  home = {
    # Ensure .ssh/config.d directory exists
    file.".ssh/config.d/.keep".text = "";

    # Activation scripts for validation
    activation = {
      # Check for age key before sops decryption to provide better error messages
      checkAgeKey = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
        $DRY_RUN_CMD ${checkAgeKeyScript}/bin/check-age-key
      '';

      # Validate SSH configuration after activation
      validateSshConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD ${validateSshConfigScript}/bin/validate-ssh-config
      '';
    };
  };
}
