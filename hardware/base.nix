{ config, lib, pkgs, ... }: {
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackages_4_19;
  boot.kernelPackages = pkgs.linuxPackages_5_1;

  #boot.loader.grub.copyKernels = true;
  boot.kernelPatches = [
    #{ name = "i2c-oops"; patch = ./i2c-oops.patch; }
  ];
}