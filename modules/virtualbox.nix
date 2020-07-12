{ config, lib, ... }:

lib.mkIf (config.networking.hostName == "nixos-desktop") {
  virtualisation.virtualbox = {
    host.enable = true;
    host.addNetworkInterface = true;
    host.enableExtensionPack = true;
    guest.enable = false;
    host.enableHardening = false;
  };
}
