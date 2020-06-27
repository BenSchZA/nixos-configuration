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
  services.xserver.libinput = {
  	enable = true;
	naturalScrolling = false; 
	middleEmulation = true; 
	tapping = true;
  };

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager = {
    sddm.enable = false;
    lightdm = {
      enable = true;
      greeters.pantheon.enable = true;
    };
    gdm.enable = false;
    gdm.wayland = false;
  };

  programs.sway.enable = true;

  services.xserver.windowManager.i3.enable = false;
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

  services.xserver.windowManager.xmonad = {
    enable = false;
    enableContribAndExtras = true;
  };
}
