# agents.md

## Project Purpose

This repository provides a declarative, reproducible configuration for macOS systems using Nix, Nix-Darwin, and Home Manager. It manages system and user-level settings, packages, and secrets, enabling easy setup and maintenance of development environments.

## Key Technologies

- **Nix**: Declarative package manager and build system.
- **Nix-Darwin**: macOS system configuration via Nix.
- **Home Manager**: User-level configuration via Nix.
- **sops-nix**: Encrypted secrets management.
- **Homebrew**: macOS package manager, integrated via Nix.
- **Doom Emacs**: Custom Emacs configuration included.

## Main Structure

- `module/`: Home Manager modules and configs for various programs (Emacs, shell, CLI tools).
- `system/`: System-level Nix configurations (macOS, Homebrew, secrets).
- `secrets/`: Encrypted secrets, managed with sops-nix and age keys.
- `README.md`: Setup instructions and usage guide.
- `flake.nix`: Flake entrypoint, defines inputs and outputs for Nix, Nix-Darwin, Home Manager, and related tools.

## Usage Overview

1. **Clone** this repo into `~/.config/nixpkgs`.
2. **Install** Determinate Nix.
3. **Build and switch** system config with `darwin-rebuild` and flake references.
4. **Update** with `nix flake update` and rebuild.
5. **Manage secrets** using sops-nix and age keys.
6. **Configure Emacs** with provided Doom Emacs setup.

## License

This project is released into the public domain (Unlicense).

---

For more details, see the README.md and flake.nix in the repository.
