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
    ./modules/synergy-client.nix
    ./secret.nix
  ];

  boot.loader.grub.devices = [ "/dev/disk/by-id/nvme-PC300_NVMe_SK_hynix_256GB_ES79N45861080990K" ];

  networking.hostId = "0edeb994";
  networking.hostName = "nixos"; # Define your hostname.

  powerManagement.enable = true;
  #powerManagement.cpuFreqGovernor = null; # Managed by tlp

  services.xserver.desktopManager = {
    default = "bspwm";
    xterm.enable = false;
    xfce = {
      enable = false;
      noDesktop = true;
      enableXfwm = false;
    };
    plasma5.enable = false;
    gnome3.enable = false;
    mate.enable = false;
    pantheon.enable = true;
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kgpg
    wget
    vim
    firefox
    networkmanager
    atom
    clang
    kate
    git
    pass
    terminator
    vlc
    remind
    borgbackup
    gnupg
    filelight
    ntfs3g
    killall
    ngrok
    ranger
    bind
    nmap
    
    gnumake
  ];

    # Enable cron service
  services.cron = {
    enable = true;
    mailto = "bscholtz.bds@gmail.com";
    systemCronJobs = [
      #"*/5 * * * *      root    date >> /tmp/cron.log"
      #"*/1 * * * *      bscholtz        . /etc/profile; . ~/.bash_profile; ~/.bin/mail/mail-periodic"
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
