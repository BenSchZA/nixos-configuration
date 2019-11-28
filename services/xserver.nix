{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  #services.xserver = {
  #  enable = true;
  #  layout = "us";
  #  xkbOptions = "eurosign:e";
  #desktopManager = {
  #  default = "xfce";
  #  xterm.enable = false;
  #  xfce = {
  #    enable = true;
  #    noDesktop = true;
  #    enableXfwm = false;
  #  };
  #};
  #  libinput.enable = true;
  #  displayManager.sddm.enable = true;
  #  windowManager.i3.enable = true;
  #};

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.multitouch.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager = {
    sddm.enable = false;
    lightdm = {
      enable = false;
      #warning: The Pantheon greeter is suboptimal in NixOS and can possibly put you in a situation where you cannot start a session when switching desktopManagers.
      greeters.pantheon.enable = false;
    };
    gdm.enable = true;
    gdm.wayland = false;
  };

  #services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager = {
    default = "bspwm";
    xterm.enable = false;
    xfce = {
      enable = false;
      noDesktop = true;
      enableXfwm = false;
    };
    plasma5.enable = false;
    gnome3.enable = true;
    mate.enable = true;
    pantheon.enable = false;
  };
  
  services.xserver.windowManager.bspwm = {
    enable = true;
    configFile = "/home/bscholtz/.config/bspwm/bspwmrc";
    sxhkd.configFile = "/home/bscholtz/.config/sxhkd/sxhkdrc";
  };

  services.xserver.xautolock = {
    enable = false;
    enableNotifier = true;
    notifier = ''${pkgs.libnotify}/bin/notify-send "Locking in 10 seconds"'';
    locker = "${pkgs.i3lock-pixeled}/bin/i3lock-pixeled";
    time = 10;
  };

  #services.xserver.windowManager.xmonad = {
  # enable = true;
  # enableContribAndExtras = true;
  #};
}
