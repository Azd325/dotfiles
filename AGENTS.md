# AGENTS.md

## Build, Lint, and Test Commands
- **Lint Nix:** `nix run nixpkgs#statix -- check .`
- **Dead Code (Nix):** `nix run nixpkgs#deadnix -- --fail .`
- **Format Nix:** `nix fmt` (RFC 166 style)
- **Check Nix Formatting:** `nix develop --command nixfmt --check`
- **Lint Lua:** Super-Linter runs with `VALIDATE_LUA: true`
- **EditorConfig rules:** Enforced via CI

## Code Style Guidelines
- **EditorConfig:** UTF-8, LF, final newline, trim trailing whitespace
- **YAML:** 2 spaces, space indent
- **Lua:** 2 spaces, space indent; globals: `vim`, `ColorMyPencils`; standard: `max` (luacheck)
- **Nix:** Use RFC 166 formatting; run `nixfmt-rfc-style` for consistency
- **Naming:** Use descriptive, conventional names per language
- **Error Handling:** Use language idioms (Lua: pcall, Nix: error propagation)
- **Imports:** Prefer explicit imports; avoid wildcards
- **Types:** Use explicit types/structure where possible
- **CI:** Linting and formatting enforced on PRs to main

Agents must follow these guidelines for all code contributions and reviews.