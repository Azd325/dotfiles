# AGENTS.md

## Build and Apply Commands
- **Apply config:** `nix develop --command apply-nix-darwin-configuration`
- **Format Nix:** `nix fmt` (RFC 166 style)
- **Check formatting:** `nix develop --command nixfmt --check`
- **Lint Nix:** `nix run nixpkgs#statix -- check .`
- **Dead code:** `nix run nixpkgs#deadnix -- --fail .`
- **Run all checks:** `nix flake check`

## Code Style Guidelines
- **EditorConfig:** UTF-8, LF, final newline, trim trailing whitespace
- **Nix:** RFC 166 formatting via `nixfmt-rfc-style`; explicit imports; avoid wildcards
- **Lua:** 2-space indent; globals: `vim`, `ColorMyPencils`; luacheck standard: `max`
- **YAML:** 2-space indent
- **Naming:** Descriptive names; keep package lists sorted alphabetically
- **Error Handling:** Use language idioms (Lua: pcall, Nix: error propagation)
- **CI:** Linting (statix, deadnix, luacheck, editorconfig, gitleaks) enforced on PRs

Agents must follow these guidelines for all code contributions and reviews.
