{ config, lib, pkgs, ... }: {
  imports = [
    ./base.nix
    ./base_desktop.nix
  ];

  boot.kernelParams = [
    "zswap.enabled=0"
    "zfs.zfs_arc_max=3000000000"
    "zfs.zfs_arc_sys_free=3000000000"
  ];

  boot.extraModprobeConfig = ''
    options zfs zfs_arc_max=3000000000
    options zfs zfs_arc_sys_free=3000000000
  '';
  
  boot.kernel.sysctl = { "vm.swappiness" = 10; };
}
