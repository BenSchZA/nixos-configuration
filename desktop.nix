# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, options, ... }:

{
  imports = [
    ./base.nix
    ./hardware-configuration.nix
    ./services/base.nix
    ./services/zfs.nix
    ./services/power.nix
    ./services/xserver.nix
    #./services/xrdp.nix
    # ./services/traefik.nix
    ./services/phoenix-blog.nix
    ./services/avahi.nix
    ./services/redis.nix
    ./modules/virtualization.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/home-manager.nix
    ./modules/synergy-server.nix
    ./secret.nix
    ./modules/kubeadm/default.nix
  ];
services.xserver.displayManager.gdm.autoSuspend = false;
  nix.nixPath = options.nix.nixPath.default ++ [
    #"nixpkgs=/home/bscholtz/workspace/nixpkgs"
    #"nixos-config=/etc/nixos/configuration.nix"
    "nixpkgs-overlays=/home/bscholtz/.config/nixpkgs/overlays/"
  ];

  networking.hostName = "nixos-desktop"; # Define your hostname.
  networking.hostId = "3f3a8aa4";

  services.xserver.videoDrivers = [ "nvidia" ]; 

  services.mongodb = {
    enable = false;
    extraConfig = ''
      net:
        port: 27017
    '';
  };

  services.kubeadm = {
    enable = false;
    # resetOnStart = true;
    role = "master";
    apiserverAddress = "192.168.1.113";
    bootstrapToken = "8tipwo.tst0nvf7wcaqjcj0";
    discoveryTokenCaCertHash = "sha256:c3e9efd010c793d2c983ea17f1e7f9346adf6018d524db0793bf550e39b1a402";
    nodeip = "192.168.1.113";
  };

  services.neo4j = {
  	enable = false;
  };

  services.zerotierone = {
    enable = false;
    joinNetworks = [];
  };

  services.ipfs = {
    enable = false;
    autoMount = true;
  };

  services.xserver.desktopManager = {
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
  
  # CUDA support
  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "/run/current-system/sw/bin/nvidia-smi"; #"${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi";
  };

  services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ]; #hamster-time-tracker

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
     extraGroups = [ "wheel" "plugdev" "vboxusers" ]; # Enable ‘sudo’ for the user.
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
    pciutils
    gcc
    #cudatoolkit
    linuxPackages.nvidia_x11
    #linuxPackages.virtualbox
  ];

    # Enable cron service
  services.cron = {
    enable = true;
    mailto = "bscholtz.bds@gmail.com";
    systemCronJobs = [
      #"*/5 * * * *      root    date >> /tmp/cron.log"
      "30 09 * * *      bscholtz        . /etc/profile; . ~/.bash_profile; ~/.bin/mail/mail-daily"
      #"*/1 * * * *      bscholtz        . /etc/profile; . ~/.bash_profile; ~/.bin/mail/mail-periodic"
      "*/5 * * * *      bscholtz        . /etc/profile; . ~/.bash_profile; ~/.bin/duck.sh >/dev/null 2>&1"
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
