{ config, pkgs, ... }:

{
  imports = [
    ./service_zfs.nix
    ./service_power.nix
    ./service_xserver.nix
  ];

  services.undervolt = {
    enable = false;
    coreOffset = "-80";
    verbose = true;
  };

  services.hostapd = {
    enable = false;
    interface = "wlp58s0";
    wpaPassphrase = "";
  };

  # List services that you want to enable:
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 15;
    freeSwapThreshold = 15;
  };
  #services.flatpak.enable = true;

  services.nexus = {
    enable = false;
    listenPort = 8081;
  };

  services.ipfs = {
    enable = false;
    autoMount = true;
  };

  # localhost:9000
  services.peerflix.enable = true;
  
  # localhost:8384
  services.syncthing = {
    enable = false;
    user = "bscholtz";
    dataDir = "/home/bscholtz/.syncthing";
  };

  services.gnome3.gnome-keyring = {
    enable = true;
  };

  services.fwupd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.sshguard.enable = false;

  services.openvpn.servers = {
    homeVPN = {
      config = "config /home/bscholtz/VPNGate/homeVPN.ovpn ";
      autoStart = false;
    };
  };

  services.mongodb.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_10;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all all trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE USER postgres;
      ALTER USER postgres PASSWORD 'postgres';
      ALTER USER postgres WITH SUPERUSER;
    '';
  };

  services.vault.enable = false; 
  services.keybase.enable = false;

  #services.kubernetes = {
  #  roles = ["master" "node"];
  #  path = [ pkgs.zfs ];
  #  apiserver.enable = true;
  #};
  #services.kubernetes.kubelet.extraOpts = "--fail-swap-on=false";
  #services.kubernetes.addons.dashboard.enable = true;

  #services.kubernetes.apiserver.basicAuthFile = pkgs.writeText "users" ''
  #	kubernetes,admin,0 
  #'';

  services.jupyter.enable = false;
  services.jupyter.password =
  "'sha1:42e2574f4a39:e13b6c64f71976283eb8e2846e6ab50f56c7685a'";
  services.jupyter.user = "bscholtz";
  services.jupyter.notebookDir = "Notebooks";
  services.jupyter.kernels = {
    python3 = let
      env = (pkgs.python3.withPackages (pythonPackages:
      with pythonPackages; [
        ipykernel
        pandas
        scikitlearn
        sympy
        plotly
        matplotlib
        #line_profiler
        memory_profiler
        psutil
        ipywidgets
      ]));
    in {
      displayName = "Python 3 for machine learning";
      argv = [
        "${env.interpreter}"
        "-m"
        "ipykernel_launcher"
        "-f"
        "{connection_file}"
      ];
      language = "python";
    };
  };

  services.tor = {
    # Slow SOCKS: port 9050
    enable = false;
    # Fast SOCKS: port 9063
    client.enable = true;
  };

  services.redshift = {
    enable = false;
    latitude = "-33.9249";
    longitude = "18.4241";
    temperature.day = 6500;
    temperature.night = 2700;
  };

  services.urxvtd.enable = true;
  services.dbus.packages = with pkgs; [ blueman ];
}
