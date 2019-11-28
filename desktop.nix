# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ./hardware-configuration.nix
    ./services/base.nix
    ./services/zfs.nix
    ./services/power.nix
    ./services/xserver.nix
    ./services/xrdp.nix
    ./services/traefik.nix
    ./modules/virtualization.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/home-manager.nix
    ./secret.nix
  ];

  #nix.nixPath = [
  #  "nixpkgs=/home/bscholtz/workspace/nixpkgs"
  #  "nixos-config=/etc/nixos/configuration.nix"
  #];

  networking.hostName = "nixos-desktop"; # Define your hostname.
  networking.hostId = "3f3a8aa4";

  services.xserver.videoDrivers = [ "nvidia" ]; 

  services.ipfs = {
    enable = true;
    autoMount = true;
  };

  services.xserver.desktopManager = {
    default = "plasma5";
    xterm.enable = false;
    xfce = {
      enable = false;
      noDesktop = true;
      enableXfwm = false;
    };
    plasma5.enable = true;
    gnome3.enable = true;
    mate.enable = false;
    pantheon.enable = false;
  };
  
  # CUDA support
  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "/run/current-system/sw/bin/nvidia-smi"; #"${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi";
  };

  services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf hamster-time-tracker];

  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome3.enable = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bscholtz = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kgpg
    polybar
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
    pciutils
    gcc
    cudatoolkit
    linuxPackages.nvidia_x11
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
