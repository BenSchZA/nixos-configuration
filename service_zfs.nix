{ config, ... }:

{
  # zfs set reservation=1G zroot
  # zfs set com.sun:auto-snapshot=true <pool>/<fs>

  services.zfs.autoScrub.enable = true;

  services.zfs.autoSnapshot = {
    enable = true;
    frequent = 0;
    hourly = 12;
    daily = 1;
    weekly = 1;
    monthly = 0;
  };
}
