# Nix Daemon Configuration with sops-nix

This repository uses `sops-nix` to manage Nix daemon configuration securely and declaratively. Currently manages GitHub access tokens for private repository access and API rate limit avoidance.

## Structure

- **Nix-managed** (`nix-config.nix`):
  - Nix daemon configuration management
  - sops-nix integration for encrypted secret decryption
  - System activation scripts (preActivation/postActivation hooks)
  - Age key validation and config format validation

- **Activation scripts** (`scripts/`):
  - `check-age-key.sh` - Validates sops age key exists before decryption
  - `validate-nix-config.sh` - Validates Nix config format after decryption
  - Built with `pkgs.writeShellApplication` for automatic shellcheck linting
  - Extracted as separate files for maintainability and linting

- **sops-encrypted** (`secrets/shared/default.yaml`):
  - Nix daemon configuration (currently: GitHub access tokens)
  - **Version controlled and encrypted with age**
  - **Shared across all hosts** (unlike host-specific SSH configs)

## How it works

1. **Age key validation**: Pre-activation check ensures `~/.config/sops/age/keys.txt` exists (blocks activation if missing)
2. **Encryption**: Configuration stored in `secrets/shared/default.yaml`, encrypted with sops using age keys
3. **Decryption**: On system activation, sops-nix decrypts to `/run/secrets/nix-config` (mode 0600, root-owned)
4. **Validation**: Pre-activation script verifies file format and permissions (blocks activation if invalid)
5. **Inclusion**: Nix daemon loads configuration via `extraOptions = "!include ${config.sops.secrets.nix-config.path}"`

The Nix daemon configuration is included in `system/nix.nix`:

```nix
nix.extraOptions = lib.optionalString hasNixConfig
  "!include ${config.sops.secrets.nix-config.path}";
```

sops-nix automatically decrypts the encrypted YAML file and makes it available at `/run/secrets/nix-config`.

## Setup on a new machine

**IMPORTANT: Bootstrap Order**

The age key must exist BEFORE the first system activation, otherwise activation will fail with validation errors. Follow these steps in order:

1. **Generate age key FIRST** at `~/.config/sops/age/keys.txt`:
   ```bash
   mkdir -p ~/.config/sops/age
   age-keygen -o ~/.config/sops/age/keys.txt
   ```

   Save the public key (starts with `age1...`) for the next step.

2. **Add public key to `.sops.yaml`** (if setting up a new machine with existing secrets):
   ```yaml
   keys:
     - &primary age1wja2r663c9t73ylvxetddvrzw4slvgtwjlscn4v8qsk52fkkccjqwpt5rd
     - &newmachine age1... # Your new public key here
   ```

   Then re-encrypt secrets with the new key:
   ```bash
   SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt nix run nixpkgs#sops -- updatekeys secrets/shared/default.yaml
   ```

3. **Clone repository and apply**:
   ```bash
   git clone <repo-url> ~/.config/nixpkgs
   cd ~/.config/nixpkgs
   nix develop --command apply-nix-darwin-configuration
   ```

4. **Verify**: The activation scripts will validate age key and config format automatically. Activation will FAIL if:
   - Age key is missing or invalid
   - Secret cannot be decrypted
   - Config format is invalid

## Editing Nix configuration

To edit the Nix daemon configuration:

```bash
# Edit the encrypted secret
SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt nix run nixpkgs#sops -- secrets/shared/default.yaml

# After saving, rebuild the configuration
nix develop --command apply-nix-darwin-configuration
```

## Configuration Format

The encrypted YAML file has the following structure:

```yaml
nix-config: access-tokens = github.com=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # gitleaks:allow
```

The `nix-config` key contains the Nix daemon configuration which gets extracted and written to `/run/secrets/nix-config`.

### Current Configuration

**GitHub Access Tokens:**
```
access-tokens = github.com=TOKEN
```

Used for:
- Private repository access during builds
- Avoiding GitHub API rate limits (60/hour → 5000/hour authenticated)

### Extending Configuration

The file can be extended with additional Nix daemon options:

**Multiple Git hosts:**
```yaml
nix-config: |
  access-tokens = github.com=ghp_xxx gitlab.com=glpat_xxx
```

**Other Nix options:**
Any option supported by Nix's `extraOptions` can be added (see `man nix.conf`).

## Benefits

- **Version controlled**: Configuration backed up in git (encrypted)
- **Declarative**: Everything managed through Nix configuration
- **Secure**: Encrypted with age, only decrypted at runtime by root
- **Production-safe**: Validation prevents misconfigurations (activation fails on errors)
- **Fail-hard behavior**: System activation blocked if age key or secrets missing/invalid
- **Clear error messages**: Validation failures provide actionable troubleshooting steps
- **Automatic**: No manual secret copying needed
- **Extensible**: Easy to add more Nix daemon configuration options
- **Validated**: Activation scripts ensure proper format and permissions before use

## Testing

Verify the configuration is working:

```bash
# Check that the secret exists and is decrypted
ls -la /run/secrets/nix-config

# Check permissions (should be -rw-------, root-owned)
ls -l /run/secrets/nix-config

# View content (requires sudo)
sudo cat /run/secrets/nix-config

# Test GitHub access with a private repository
nix flake metadata github:yourorg/private-repo

# Check activation log for validation messages
# Should show:
#   ✓ sops age key validated at ~/.config/sops/age/keys.txt
#   ✓ Nix configuration validated at /run/secrets/nix-config
```

## Troubleshooting

### Age key not found

```
⚠️  WARNING: sops age key not found at ~/.config/sops/age/keys.txt
   Secrets decryption will fail. Generate key with:
   mkdir -p ~/.config/sops/age && age-keygen -o ~/.config/sops/age/keys.txt
   Then add public key to .sops.yaml
```

**Solution:**
1. Generate age key: `age-keygen -o ~/.config/sops/age/keys.txt`
2. Add public key to `.sops.yaml` under `keys` section
3. Re-encrypt secrets: `sops updatekeys secrets/shared/default.yaml`
4. Rebuild: `nix develop --command apply-nix-darwin-configuration`

### Secret decryption failed

**Symptom:** `/run/secrets/nix-config` doesn't exist after activation

**Possible causes:**
- Age key doesn't match recipients in `.sops.yaml`
- Secret file not encrypted with current age key
- Secret file path doesn't match `path_regex` in `.sops.yaml`

**Solution:**
```bash
# Verify age key can decrypt
SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt nix run nixpkgs#sops -- -d secrets/shared/default.yaml

# If decryption fails, re-encrypt with correct key
SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt nix run nixpkgs#sops -- updatekeys secrets/shared/default.yaml
```

### Invalid configuration format

```
ERROR: Nix configuration file has invalid format
Expected: access-tokens = github.com=ghp_...
```

**Solution:**
Edit the secret file and ensure format matches:
```yaml
nix-config: access-tokens = github.com=TOKEN
```

Note: No quotes around the value, no extra whitespace.

### Permission denied accessing secret

**Symptom:** Cannot read `/run/secrets/nix-config`

**Expected behavior:** Secret is root-owned with mode 0600. Only Nix daemon (root) can read it.

**Solution:** Use `sudo cat /run/secrets/nix-config` to view.

## Adding More Nix Configuration

To add other Nix daemon options beyond GitHub tokens:

1. **Edit the encrypted secret**:
   ```bash
   SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt nix run nixpkgs#sops -- secrets/shared/default.yaml
   ```

2. **Add configuration** in Nix `extraOptions` format:
   ```yaml
   nix-config: |
     access-tokens = github.com=ghp_xxx gitlab.com=glpat_xxx
     # Add other nix.conf options here
     keep-outputs = true
     keep-derivations = true
   ```

3. **Update validation script** (optional) if you want to validate the new options:
   Edit `system/scripts/validate-nix-config.sh` to add format checks.

4. **Test the configuration**:
   ```bash
   nix develop --command apply-nix-darwin-configuration
   ```

5. **Verify** Nix daemon loaded the config:
   ```bash
   sudo cat /run/secrets/nix-config
   # Check Nix daemon is using the configuration
   nix show-config | grep -E "access-tokens|keep-outputs"
   ```

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
system/
├── nix-config.nix                      # Main Nix module
├── nix.nix                              # Nix daemon settings (uses nix-config)
├── sops.nix                             # Age configuration
├── scripts/
│   ├── check-age-key.sh                 # Pre-activation validation
│   └── validate-nix-config.sh           # Post-activation validation
└── README.md                            # This file
```

### Adding new scripts:
1. Create script in `system/scripts/` directory
2. Add to module using `pkgs.writeShellApplication`:
   ```nix
   let
     myScript = pkgs.writeShellApplication {
       name = "my-script";
       runtimeInputs = [ pkgs.coreutils pkgs.gnugrep ];
       text = builtins.readFile ./scripts/my-script.sh;
     };
   in
   {
     system.activationScripts.preActivation.text = lib.mkBefore ''
       ${myScript}/bin/my-script
     '';
   }
   ```
3. Reference in activation with `${scriptName}/bin/script-name`
4. Run `git add` to include in Nix flake (required!)

### System-level vs Home Manager activation

**System-level** (`system.activationScripts`):
- Runs as root during `darwin-rebuild switch`
- Uses `lib.mkBefore` / `lib.mkAfter` for ordering
- Three main hooks: `preActivation`, `extraActivation`, `postActivation`
- No DAG (Directed Acyclic Graph) ordering like Home Manager

**Home Manager** (`home.activation`):
- Runs as user during home-manager activation
- Uses `lib.hm.dag.entryBefore` / `lib.hm.dag.entryAfter` for DAG ordering
- Has `$DRY_RUN_CMD` variable for dry-run support

Example:
```nix
# System-level (root)
system.activationScripts.preActivation.text = lib.mkBefore ''
  echo "Running as root before activation"
'';

# Home Manager (user)
home.activation.myActivation = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  echo "Running as user after writeBoundary"
'';
```

## Related Documentation

- **Main README**: Basic sops-nix setup and initial installation
- **SSH module**: `modules/home-manager/programs/ssh/README.md` (similar sops-nix pattern for user-level)
- **sops-nix upstream**: https://github.com/Mic92/sops-nix
- **age encryption**: https://github.com/FiloSottile/age
- **Nix manual**: https://nixos.org/manual/nix/stable/command-ref/conf-file.html

<!-- TODO: Extract shared sops-nix documentation to docs/SOPS.md -->
<!-- TODO: Extract shared shell script patterns to docs/SHELL-SCRIPTS.md -->
<!-- TODO: Consider moving system-level modules to subdirectories with individual READMEs -->
