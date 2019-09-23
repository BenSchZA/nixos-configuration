{ config, lib, pkgs, ... }: {
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackages_4_19;
  boot.kernelPackages = pkgs.linuxPackages_5_1;

  boot.kernelParams = [
    "zswap.enabled=1"
    "zfs.zfs_arc_max=1073741824"
  ];

  #boot.extraModulePackages = [ ];
  boot.extraModprobeConfig = ''
    options zfs zfs_arc_max=1073741824
  ''; #options ath10k_core skip_otp=y
  boot.kernel.sysctl = { "vm.swappiness" = 1; };

  #boot.loader.grub.copyKernels = true;
  boot.kernelPatches = [
    #{ name = "i2c-oops"; patch = ./i2c-oops.patch; }
  ];
}