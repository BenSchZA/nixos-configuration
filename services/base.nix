{ config, pkgs, ... }:

{
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
    # Nano S
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0001|1000|1001|1002|1003|1004|1005|1006|1007|1008|1009|100a|100b|100c|100d|100e|100f|1010|1011|1012|1013|1014|1015|1016|1017|1018|1019|101a|101b|101c|101d|101e|101f", TAG+="uaccess", TAG+="udev-acl"
  '';

  services.hostapd = {
    enable = false;
    interface = "wlp58s0";
    wpaPassphrase = "";
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
  services.peerflix.enable = false;
  
  # localhost:8384
  services.syncthing = {
    enable = false;
    user = "bscholtz";
    dataDir = "${config.users.users.bscholtz.home}/.syncthing";
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
      config = "config ${config.users.users.bscholtz.home}/VPNGate/homeVPN.ovpn ";
      autoStart = false;
    };
  };

  services.postgresql = {
    enable = true;
    port = 5432;
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
  services.keybase.enable = true;

  # services.kubernetes = {
  #   masterAddress = "localhost";
  #   roles = ["master" "node"];
  #   path = [ pkgs.zfs ];
  #   apiserver.enable = true;
  # };
  # services.kubernetes.kubelet.extraOpts = "--fail-swap-on=false";
  # services.kubernetes.addons.dashboard.enable = true;

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
    client.enable = false;
  };

  services.redshift = {
    enable = false;
    temperature.day = 6500;
    temperature.night = 2700;
  };
  location.latitude = -33.9249;
  location.longitude = 18.4241;

  services.urxvtd.enable = true;
  #services.dbus.packages = with pkgs; [ blueman ];
}
