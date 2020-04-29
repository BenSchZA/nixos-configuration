{ config, lib, pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_latest; #_4_19;

  #boot.loader.grub.copyKernels = true;
  boot.kernelPatches = [
    #{ name = "i2c-oops"; patch = ./i2c-oops.patch; }
  ];
}
