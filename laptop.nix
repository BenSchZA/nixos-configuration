# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    #<nixos-hardware/dell/xps/13-9360>
    /home/bscholtz/workspace/Nix/nixos-hardware/dell/xps/13-9360
    ./base.nix
    ./hardware-configuration.nix
    ./services/base.nix
    ./services/zfs.nix
    ./services/power.nix
    ./services/xserver.nix
    ./modules/virtualization.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/home-manager.nix
    ./secret.nix
  ];

  boot.loader.grub.devices = [ "/dev/disk/by-id/nvme-PC300_NVMe_SK_hynix_256GB_ES79N45861080990K" ];

  networking.hostId = "0edeb994";
  networking.hostName = "nixos"; # Define your hostname.

  powerManagement.enable = true;
  #powerManagement.cpuFreqGovernor = null; # Managed by tlp

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    # Steam setup
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 15;
    freeSwapThreshold = 15;
  };

  services.undervolt = {
    enable = false;
    coreOffset = "-80";
    verbose = true;
  };

  users.users.guest = {
    isNormalUser = true;
    home = "/home/guest";
    extraGroups = [ "wheel" "audio" ];
    shell = pkgs.zsh;
  };

  users.groups.plugdev = { };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
