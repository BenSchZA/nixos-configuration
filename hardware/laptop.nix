{ config, lib, pkgs, ... }: {
  imports = [
    ./base.nix
    ./base_laptop.nix
  ];

  boot.extraModprobeConfig = ''
    options zfs zfs_arc_min=100000000
    options zfs zfs_arc_max=1000000000
    options zfs zfs_arc_sys_free=4000000000
  '';

  boot.kernel.sysctl = { "vm.swappiness" = 10; };

  # Suspected bluetooth causing hardware issues 
  hardware.bluetooth.powerOnBoot = false;
  powerManagement = {
    powerUpCommands = "rfkill unblock wlan";
    powerDownCommands = "rfkill block wlan";
  }; 

  boot.kernelParams = [
    # Enable GuC / HuC firmware loading for Skylake and newer processors
    #"i915.enable_guc_loading=1"
    #"i915.enable_guc_submission=1"
    # Making use of Framebuffer compression (FBC) can reduce power consumption while reducing memory bandwidth needed for screen refreshes
    #"i915.enable_fbc=1"
    # The goal of Intel Fastboot is to preserve the frame-buffer as setup by the BIOS or bootloader to avoid any flickering until Xorg has started
    "i915.fastboot=1"
    #"i915.enable_rc6=1"
    #"i915.modeset=1"
    "zswap.enabled=1"
    "zfs.zfs_arc_max=1000000000"
    "zfs.zfs_arc_sys_free=4000000000"
  ];

  nix.maxJobs = lib.mkDefault 4; # 8
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
