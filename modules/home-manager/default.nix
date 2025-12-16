{
  config,
  inputs,
  username,
  userHome,
  ...
}:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.zen-browser.homeModules.twilight
    ./files
    ./fonts.nix
    ./packages.nix
    ./programs
  ];

  home = {
    stateVersion = "24.11";
    inherit username;
    homeDirectory = userHome;
    sessionPath = [
      # own scripts
      "$HOME/.local/bin"
      # cargo installed binaries
      "$HOME/.cargo/bin"
      # Doom Emacs binary
      "$HOME/.config/emacs/bin"
      # postgres helper e.g createdb, dropdb, psql
      "/Applications/Postgres.app/Contents/Versions/latest/bin"
      # Android SDK
      "$ANDROID_SDK_ROOT/emulator"
      "$ANDROID_SDK_ROOT/platform-tools"
      "$ANDROID_SDK_ROOT/tools"
    ];
    sessionVariables = {
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
      PAGER = "less -FiRSwX";

      GDAL_LIBRARY_PATH = "/opt/homebrew/opt/gdal/lib/libgdal.dylib";
      GEOS_LIBRARY_PATH = "/opt/homebrew/opt/geos/lib/libgeos_c.dylib";
      # Android SDK
      ANDROID_SDK_ROOT = "$HOME/Library/Android/sdk";
      ANDROID_SDK = "${config.home.sessionVariables.ANDROID_SDK_ROOT}";
      SOPS_AGE_KEY_FILE = "${userHome}/.config/sops/age/keys.txt";
    };
  };
  manual.manpages.enable = false;
  programs.man.enable = false;

  sops.age = {
    keyFile = "${userHome}/.config/sops/age/keys.txt";
    sshKeyPaths = [ ];
  };
}
