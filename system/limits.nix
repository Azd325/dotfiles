_: {
  # Required for Nix on macOS to avoid "Too many open files"
  # when fetching large inputs (e.g. homebrew-core).
  #
  # Creates a LaunchDaemon that sets system-wide file descriptor limits.
  # According to launchd.plist(5), setting NumberOfFiles in a system-wide daemon
  # will set kern.maxfiles (soft) and kern.maxfilesperproc (hard) sysctl values.
  #
  # These limits take effect after the daemon loads (at boot or rebuild).
  # Verify with: launchctl limit maxfiles && ulimit -n
  launchd.daemons.limit-maxfiles = {
    script = ''
      echo "Setting maxfiles limit..."
      launchctl limit maxfiles 524288 1048576
    '';
    serviceConfig = {
      Label = "org.nixos.limit-maxfiles";
      RunAtLoad = true;
    };
  };
}
