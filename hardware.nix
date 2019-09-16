{ config, lib, pkgs, ... }: {
 
  # Suspected bluetooth causing hardware issues 
  hardware.bluetooth.powerOnBoot = false;
  powerManagement = {
    powerUpCommands = "rfkill unblock bluetooth";
    powerDownCommands = "rfkill block bluetooth";
  };  

  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackages_4_19;
  boot.kernelPackages = pkgs.linuxPackages_5_1;

  boot.kernelParams = [
    "zswap.enabled=1"
    # Enable GuC / HuC firmware loading for Skylake and newer processors
    #"i915.enable_guc_loading=1"
    #"i915.enable_guc_submission=1"
    # Making use of Framebuffer compression (FBC) can reduce power consumption while reducing memory bandwidth needed for screen refreshes
    #"i915.enable_fbc=1"
    # The goal of Intel Fastboot is to preserve the frame-buffer as setup by the BIOS or bootloader to avoid any flickering until Xorg has started
    "i915.fastboot=1"
    #"i915.enable_rc6=1"
    #"i915.modeset=1"
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

  nix.maxJobs = lib.mkDefault 4; # 8
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
