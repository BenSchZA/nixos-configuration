{ config, lib, pkgs, ... }: {
  imports = [
    ./base.nix
    ./base_desktop.nix
  ];

  boot.kernelParams = [
    "zswap.enabled=1"
    "zfs.zfs_arc_max=5000000000"
    "zfs.zfs_arc_sys_free=5000000000"
  ];

  boot.extraModprobeConfig = ''
    options zfs zfs_arc_max=5000000000
    options zfs zfs_arc_sys_free=5000000000
  '';
  
  boot.kernel.sysctl = { "vm.swappiness" = 10; };
}
