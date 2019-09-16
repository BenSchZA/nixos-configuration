# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    #<nixos-hardware/dell/xps/13-9360>
    #/home/bscholtz/workspace/Nix/nixos-hardware/dell/xps/13-9360
    ./hardware-configuration.nix
    ./hardware.nix # Custom hardware configuration
    ./packages.nix
    ./services.nix
    ./networking.nix
    ./home-manager.nix
    ./secret.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.devices = [ "/dev/disk/by-id/nvme-PC300_NVMe_SK_hynix_256GB_ES79N45861080990K" ];
    };
    #zfs set atime=off rpool
    supportedFilesystems = [ "zfs" ];
    zfs.enableUnstable = true;
    # This doesn't work with encryption!
    #plymouth.enable = true;
  };

  fileSystems."/".options = [ "noatime" "nodiratime" ]; # "discard"

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
    extraOptions = ''
      min-free = ${toString (1024 * 1024 * 1024)}
      max-free = ${toString (5 * 1024 * 1024 * 1024)}
    '';
  };

  environment = {
    etc.current-nixos-config.source = ./.;
    variables.NIX_AUTO_RUN = "1";

    shellAliases = {
      vpn-on = "systemctl start openvpn-homeVPN";
      vpn-off = "systemctl stop openvpn-homeVPN";
      l = "ls -alh";
      ll = "ls -l";
      #ls = "ls --color=tty";
      ls = "exa";
      cat = "bat";
      find = "fd";
      #ssh-add = "eval `ssh-agent` && sudo ssh-add";
      nixos-switch = "sudo nixos-rebuild switch";
      refresh-kde-menu = "kbuildsycoca5";
      compose = "docker-compose";
    };
  };

  #programs.fish.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      theme = "avit";
      plugins = [ 
        "z" 
        "nix-shell"
        #"fzf" 
      ];
    };
    autosuggestions.enable = true;
  };

  programs.adb.enable = true;

  programs.gnupg.agent = {
    enable = false;
    enableSSHSupport = true;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  fonts.fonts = with pkgs; [
    terminus_font
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    font-awesome-ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
    source-code-pro
    overpass
    inconsolata
    powerline-fonts
  ];

  fonts.fontconfig.ultimate.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

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

  users.users.guest = {
    isNormalUser = true;
    home = "/home/guest";
    extraGroups = [ "wheel" "audio" ];
    shell = pkgs.zsh;
  };

  users.groups.plugdev = { };

  # LedgerLive rules
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1b7c", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="2b7c", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="3b7c", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="4b7c", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1807", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1808", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0000", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0001", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0004", MODE="0660", GROUP="plugdev"
  '';

  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs"; #systemd.services.docker.after = ["var-lib-docker.mount"];
      autoPrune.enable = false;
      enableOnBoot = true;
    };

    virtualbox = {
      host.enable = true;
      host.addNetworkInterface = true;
      host.enableExtensionPack = true;
      guest.enable = false;
    };

    libvirtd.enable = true;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
