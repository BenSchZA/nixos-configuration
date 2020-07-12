{ config, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs"; #systemd.services.docker.after = ["var-lib-docker.mount"];
      autoPrune.enable = false;
      enableOnBoot = true;
    };

    libvirtd.enable = true;
  };
}
