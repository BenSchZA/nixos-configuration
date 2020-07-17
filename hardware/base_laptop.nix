# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }: {

  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    #"usb_storage" 
    #"sd_mod" 
    "rtsx_pci_sdmmc"
  ];
  boot.kernelModules = [ "kvm-intel" "i915" ];

  fileSystems."/" = {
    device = "rpool/root/nixos";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "rpool/home";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/651B-2FA9";
    fsType = "vfat";
  };

  #swapDevices =
  #[{ device = "/dev/disk/by-uuid/67989bd5-3c0c-4593-be20-448e6ce03bed"; }];

}
