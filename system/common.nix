{
  lib,
  username,
  userHome,
  ...
}:
{
  # The "90%" - Shared darwin configuration imported by all hosts
  # This aggregates all shared system modules
  #
  # Import order is primarily for human readability and documentation of
  # logical dependencies. The module system merges all definitions in a
  # fixed-point, so import order doesn't affect evaluation correctness.

  imports = [
    ./sops.nix # Defines sops.secrets (referenced conditionally by nix.nix)
    ./nix.nix # Nix daemon settings (uses config.system.primaryUser)
    ./security.nix
    ./system-defaults.nix
    ./fonts.nix # System-wide font configuration
    ./homebrew.nix
    ./limits.nix # System-wide file descriptor limits for Nix operations
  ];

  # Set default primaryUser using specialArgs.username
  # This creates a single source of truth that all system modules can read
  # via config.system.primaryUser. Can be overridden per host if needed.
  # Pattern: specialArgs (input) → config option (canonical) → module consumers
  system.primaryUser = lib.mkDefault username;

  # User definition
  users.users.${username}.home = userHome;
}
