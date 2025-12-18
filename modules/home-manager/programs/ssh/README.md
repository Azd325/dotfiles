# SSH Configuration with sops-nix

This repository uses SSH's `Include` directive combined with `sops-nix` to manage SSH host configurations securely and declaratively.

## Structure

- **Nix-managed** (`default.nix`):
  - SSH client options (AddKeysToAgent, UseKeychain, etc.)
  - Default identity file for all hosts
  - sops-nix configuration for decrypting SSH hosts
  - Activation validation to ensure SSH config is properly decrypted

- **Activation scripts** (`scripts/`):
  - `validate-ssh-config.sh` - Validates decrypted SSH config
  - Built with `pkgs.writeShellApplication` for automatic shellcheck linting
  - Extracted as separate files for maintainability and linting

- **sops-encrypted** (`secrets/hosts/<hostname>/ssh-hosts.yaml`):
  - Individual SSH host configurations (encrypted)
  - Hostnames, usernames, and identity files
  - **Version controlled and encrypted with age**
  - **Host-specific**: Each machine automatically uses its own secret file

## How it works

1. **Dynamic host detection**: The module uses `osConfig.networking.hostName` to determine which host's secrets to use
2. **Encryption**: SSH host configurations are stored in `secrets/hosts/<hostname>/ssh-hosts.yaml` and encrypted with sops using age keys
3. **Decryption**: On system activation, sops-nix decrypts the file to `~/.ssh/config.d/hosts`
4. **Validation**: An activation script (with automatic shellcheck) verifies the file exists and has correct permissions (600)
5. **Include**: SSH reads the configuration via the `Include ~/.ssh/config.d/hosts` directive

The Nix configuration generates `~/.ssh/config` which includes:

```ssh-config
Include ~/.ssh/config.d/hosts
```

sops-nix automatically decrypts the encrypted YAML file and creates a symlink at `~/.ssh/config.d/hosts`.

## Setup on a new machine

1. **Set hostname** in your system configuration (e.g., `system/hosts/newhost.nix`):
   ```nix
   networking.hostName = "NEWHOST";
   ```
2. **Create host-specific secrets directory**:
   ```bash
   mkdir -p secrets/hosts/newhost  # Use lowercase of hostname
   ```
3. **Create and encrypt SSH hosts file**:
   ```bash
   # Copy template from existing host
   cp secrets/hosts/ber/ssh-hosts.yaml secrets/hosts/newhost/ssh-hosts.yaml

   # Edit with your SSH hosts (will decrypt, let you edit, then re-encrypt)
   SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt nix run nixpkgs#sops -- secrets/hosts/newhost/ssh-hosts.yaml
   ```
4. **Ensure you have your age key** at `~/.config/sops/age/keys.txt`
5. **Apply the configuration**:
   ```bash
   nix develop --command apply-nix-darwin-configuration
   ```
6. **Verify**: The activation script will validate that the SSH hosts file exists and has correct permissions

## Editing SSH hosts

To edit the SSH host configurations for your current machine:

```bash
# The hostname is automatically detected from your system config
# For hostname "BER", this edits secrets/hosts/ber/ssh-hosts.yaml
SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt nix run nixpkgs#sops -- secrets/hosts/$(hostname | tr '[:upper:]' '[:lower:]')/ssh-hosts.yaml

# After saving, rebuild the configuration
nix develop --command apply-nix-darwin-configuration
```

## Benefits

- **Version controlled**: SSH configurations are backed up in git (encrypted)
- **Declarative**: Everything managed through Nix configuration
- **Secure**: Encrypted with age, only decrypted at runtime
- **Multi-machine**: Automatically uses host-specific secrets based on hostname
- **Automatic**: No manual file copying needed on new machines
- **Standard SSH**: Still uses the clean Include directive pattern
- **Validated**: Activation scripts ensure proper file permissions and existence

## Testing

Verify the configuration is working:

```bash
# Check that the secret exists and is decrypted
ls -la ~/.ssh/config.d/hosts

# Check permissions (should be -rw-------)
ls -l ~/.ssh/config.d/hosts

# Test SSH config resolution (replace 'example-host' with your actual host)
ssh -G example-host | grep -E "^hostname|^user"

# Verify decryption works manually for your current host
SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt nix run nixpkgs#sops -- -d secrets/hosts/$(hostname | tr '[:upper:]' '[:lower:]')/ssh-hosts.yaml
```

## File Format

The encrypted YAML file has the following structure:

```yaml
ssh-config: |
  Host example
    HostName example.com
    User myuser
    IdentityFile ~/.ssh/id_example
```

The `ssh-config` key contains the raw SSH configuration which gets extracted and written to `~/.ssh/config.d/hosts`.

## Shell Script Organization

Activation scripts are extracted into separate `.sh` files in the `scripts/` directory for better maintainability:

### Benefits:
- ✅ **Automatic shellcheck**: Scripts are built with `pkgs.writeShellApplication` which runs shellcheck at build time
- ✅ **Syntax highlighting**: Full editor support for shell scripts
- ✅ **Linting in CI**: shellcheck runs in GitHub Actions and `nix flake check`
- ✅ **Testable**: Scripts can be tested independently
- ✅ **EditorConfig**: Consistent formatting with `.editorconfig` rules

### Structure:
```
modules/home-manager/programs/ssh/
├── default.nix                         # Main Nix module
├── scripts/
│   └── validate-ssh-config.sh          # Activation validation script
└── README.md                           # This file
```

### Adding new scripts:
1. Create script in `scripts/` directory
2. Add to Nix module using `pkgs.writeShellApplication`
3. Reference in activation with `${scriptName}/bin/script-name`
4. Run `git add` to include in Nix flake (required!)

Example:
```nix
let
  myScript = pkgs.writeShellApplication {
    name = "my-script";
    text = builtins.readFile ./scripts/my-script.sh;
  };
in
{
  home.activation.myActivation = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${myScript}/bin/my-script
  '';
}
```
