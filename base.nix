# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
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
      #ls = "exa";
      cat = "bat";
      #find = "fd";
      #ssh-add = "eval `ssh-agent` && sudo ssh-add";
      nixos-switch = "sudo nixos-rebuild switch";
      refresh-kde-menu = "kbuildsycoca5";
      compose = "docker-compose";
      vim = "nvim";
      emacs = "XLIB_SKIP_ARGB_VISUALS=1 emacs & disown";
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
        #"nix-shell"
        #"fzf" 
      ];
    };
    autosuggestions.enable = true;
  };

  programs.adb.enable = true;
  programs.java.enable = true;

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

  fonts.enableDefaultFonts = true;
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
    source-serif-pro
  ];

  fonts.fontconfig = {
	ultimate.enable = true;
      	penultimate.enable = false;
      	defaultFonts = {
        	monospace = [ "Source Code Pro" ];
        	sansSerif = [ "Source Sans Pro" ];
        	serif = [ "Source Serif Pro" ];
      	};
  };

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

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
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    pulseaudio.support32Bit = true;
  };
}
