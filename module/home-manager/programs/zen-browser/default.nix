{ inputs, pkgs, ... }:
let
  zenPackage = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight;
in
{
  programs.zen-browser = {
    enable = false;
    package = zenPackage;
    policies =
      let
        mkLockedAttrs = builtins.mapAttrs (
          _: value: {
            Value = value;
            Status = "locked";
          }
        );
      in
      {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        Preferences = mkLockedAttrs {
          "browser.tabs.warnOnClose" = false;
        };
      };
  };
}
