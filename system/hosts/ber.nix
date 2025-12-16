{ username, ... }:
{
  # Host-specific configuration for BER
  # username is provided via specialArgs from darwin.nix

  imports = [ ../common.nix ];

  # Host identity and networking
  networking = {
    computerName = "Tim's 💻";
    hostName = "BER";
    dns = [
      "1.1.1.1"
      "2606:4700:4700::1111"
      "1.0.0.1"
      "2606:4700:4700::1001"
    ];
    # networksetup -listallnetworkservices
    knownNetworkServices = [ "Wi-Fi" ];
  };

  # Host-specific system settings
  system = {
    # Used for backwards compatibility, please read the changelog before changing
    # $ darwin-rebuild changelog
    stateVersion = 4;

    # Override the default primaryUser from common.nix if needed
    # (common.nix sets this to username by default via lib.mkDefault)
    primaryUser = username;
  };
}
