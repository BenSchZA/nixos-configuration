{ config, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs"; #systemd.services.docker.after = ["var-lib-docker.mount"];
      autoPrune.enable = false;
      enableOnBoot = true;
    };

    virtualbox = {
      host.enable = true;
      host.addNetworkInterface = true;
      host.enableExtensionPack = true;
      guest.enable = false;
      host.enableHardening = false;
    };

    libvirtd.enable = true;
  };
}
