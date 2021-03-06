{ config, pkgs, ... }:

let

  nixos = import <nixos> { };
  unstable = import <nixpkgs-unstable> { };

  colours = {
    accent = "#E47023";
    light = "#DEE9DB";
    mlight = "#B3C0B2";
    mdark = "#5C6D69";
    mdark2 = "#222827";
    mdark3 = "#001621";
    dark = "#000F16";

    red = "#e23822";
    dred = "#a22718";

    green = "#22e258";
    dgreen = "#18a33f";

    yellow = "#e2e222";
    dyellow = "#a2a218";

    #blue = "#2288e2";
    #dblue = "#1861a3";
    blue = "#5ecfff";
    dblue = "#0cb7ff";

    magenta = "#e22265";
    dmagenta = "#a21749";

    cyan = "#22d9e2";
    dcyan = "#189ba3";
  };

in {
  imports = [
    "${
      builtins.fetchTarball
      "https://github.com/rycee/home-manager/archive/release-20.03.tar.gz"
    }/nixos"
  ];

  home-manager.users.bscholtz = {
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      pkgs.home-manager
      pkgs.android-udev-rules
      pkgs.thunderbird
      pkgs.nodePackages.node2nix
      pkgs.gparted
      pkgs.konversation
      pkgs.ghostwriter
      pkgs.ark
      #pkgs.kdiff3
      pkgs.meld
      unstable.emacs
      pkgs.kdeconnect
      pkgs.simplescreenrecorder
      pkgs.docker-compose
      pkgs.dropbox
      pkgs.gitkraken
      pkgs.homesick
      pkgs.okular
      pkgs.plasma-nm
      #pkgs.python27
      pkgs.redshift
      pkgs.redshift-plasma-applet
      pkgs.geoclue2
      pkgs.slack
      pkgs.spotify
      unstable.zoom-us
      #(pkgs.zoom-us.overrideAttrs (super: {
      #  postInstall = ''
      #    ${super.postInstall}
      #    wrapProgram $out/bin/zoom-us --set LIBGL_ALWAYS_SOFTWARE 1
      #  '';
      #}))
      #pkgs.torbrowser
      #pkgs.hedgewars
      #pkgs.virtualbox
      pkgs.libreoffice
      pkgs.spectacle
      pkgs.qtcreator
      pkgs.appimage-run
      #pkgs.idea.idea-ultimate
      pkgs.neofetch
      pkgs.ranger
      pkgs.thefuck
      #pkgs.tldr
      pkgs.tealdeer # Rust version of tldr
      pkgs.zim
      pkgs.debootstrap
      (chromium.override {
        commandLineArgs = "--load-media-router-component-extension=1";
      })
      pkgs.brave
      pkgs.macchanger
      #pkgs.minecraft
      
      #pkgs.yarn
      #pkgs.nodejs-10_x
      
      #terraform
      pkgs.vault
      pkgs.kubectl
      pkgs.minikube
      
      #pkgs.robomongo
      pkgs.mongodb-compass
      
      pkgs.octave
      vscode
      #pkgs.kicad
      pkgs.blueman
      pkgs.filezilla
      pkgs.apacheHttpd
      pkgs.direnv
      pkgs.discord
      pkgs.dmenu
      pkgs.iodine
      #pkgs.lorri

      pkgs.remind
      pkgs.postman 
      #unstable.postman
      pkgs.openssl
      pkgs.lynis
      pkgs.xorg.xbacklight

      pkgs.gimp
      pkgs.inkscape
      pkgs.imagemagick

      pkgs.tcpdump

      pkgs.inetutils
      pkgs.sxhkd
      pkgs.xdotool
      pkgs.xfce.xfce4-appfinder
      pkgs.xfce.xfce4-panel
      
      pkgs.material-icons
      pkgs.bats
      pkgs.dpkg
      pkgs.networkmanagerapplet
      pkgs.psmisc

      #pkgs.vivaldi
      #pkgs.vivaldi-ffmpeg-codecs
      pkgs.speedtest-cli
      pkgs.cachix
      pkgs.heroku
      pkgs.gotop
      pkgs.kind
      pkgs.gettext
      pkgs.bettercap
      pkgs.bc
      pkgs.curl
      pkgs.openscad
      pkgs.kompose
      #pkgs.seahorse # GPG key management GUI
      pkgs.speedcrunch
      pkgs.dia
      pkgs.buku
      (pkgs.wine.override { wineBuild = "wineWow"; })
      #pkgs.texlive.combined.scheme-medium
      pkgs.neovim
      pkgs.synergy
      pkgs.peek
      pkgs.tmux
      pkgs.pencil
      pkgs.hugo
      pkgs.plank
      pkgs.spotifyd
      pkgs.texmaker
      pkgs.unzip
      pkgs.weather
      #pkgs.darktable
      pkgs.ksysguard
      pkgs.nixfmt
      pkgs.asciinema
      pkgs.msr-tools
      #pkgs.pypi2nix # Rather install using `nix-env -if https://github.com/nix-community/pypi2nix/tarball/master`
      pkgs.rofi
      pkgs.feh
      pkgs.ripgrep-all
      #pkgs.protonmail-bridge
      pkgs.awscli
      pkgs.helm
      pkgs.franz
      pkgs.wireguard
      unstable.polybar
      unstable.i3lock
      unstable.hexchat
      unstable.quasselClient
      vagrant
      mosh
      autossh
      audacity
      obs-studio
      kdenlive
      #@
    ];

    programs.home-manager.enable = true;
    programs.command-not-found.enable = true;

    services.network-manager-applet.enable = false;
    services.blueman-applet.enable = false;
    services.lorri.enable = true;
    
    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 21600;
      maxCacheTtl = 21600;
      enableSshSupport = true;
    };

    programs.vscode = {
      enable = false;
      userSettings = {
        "[nix]"."editor.tabSize" = 2;
        "files.autosave" = "off";
        "window.zoomlevel" = 0;
        "rust-client.rustupPath" = "/home/bscholtz/.nix-profile/bin/rustup";
      };
      extensions = [
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          name = "vsliveshare-pack";
          publisher = "MS-vsliveshare";
          version = "0.2.12";
          sha256 = "1y08g56jyy1kr4jqd2x9r72bzd287yfcljbg89ghd4yfnhf4jr23";
        })
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          name = "vsliveshare";
          publisher = "MS-vsliveshare";
          version = "1.0.67";
          sha256 = "1shy9xaqz1wsyzzz5z8g409ma5h5kaic0y7bc1q2nxy60gbq828n";
        })
        pkgs.vscode-extensions.bbenoist.Nix
      ];
    };

    programs.texlive = {
    	enable = true;
	extraPackages = texlive: {
		inherit (texlive) scheme-full collection-basic collection-latex enumitem fontawesome5 fontawesome xkeyval
		xetex setspace fontspec
                chktex xifthen ifmtarg filehook
                upquote tools ms geometry graphics oberdiek
                fancyhdr lastpage xcolor etoolbox unicode-math
                ucharcat sourcesanspro tcolorbox pgf environ
                trimspaces parskip hyperref url euenc
                collection-fontsrecommended;
	};
    };

    programs.urxvt = {
      enable = true;
      transparent = false;
      scroll.bar.enable = false;
      fonts = [ "xft:Source Code Pro:size=12:antialias=true" ];
      keybindings = {
        "Shift-Control-C" = "eval:selection_to_clipboard";
        "Shift-Control-V" = "eval:paste_clipboard";
      };
      extraConfig = {
        "*iso14755" = "false";
        "*iso14755_52" = "false";
        "cursorColor" = colours.accent;
        "*background" = "[90]#31363b";
        "*depth" = "32";
        "*foreground" = colours.light;
        #!*foreground" #657b83
        #!!*fading" 40
        #!!*fadeColor" #002b36
        #!!*cursorColor" #93a1a1
        #!!*pointerColorBackground" #586e75
        #!!*pointerColorForeground" #93a1a1
        #!! black dark/light
        "*color0" = "#31363b";
        "*color8" = colours.mdark;
        #!! red dark/light
        "*color1" = colours.dred;
        "*color9" = colours.red;
        #!! green dark/light
        "*color2" = colours.dgreen;
        "*color10" = colours.green;
        #!! yellow dark/light
        "*color3" = colours.dyellow;
        "*color11" = colours.yellow;
        #!! blue dark/light
        "*color4" = colours.dblue;
        "*color12" = colours.blue;
        #!! magenta dark/light
        "*color5" = colours.dmagenta;
        "*color13" = colours.magenta;
        #!! cyan dark/light
        "*color6" = colours.dcyan;
        "*color14" = colours.cyan;
        #!! white dark/light
        "*color7" = colours.light;
        "*color15" = colours.mlight;
        #!! bold color
        #!!URxvt.colorDB" #A85C28
        #!!URxvt.colorIT" #A85C28
        #!!URxvt.underlineColor" #A85C28
        #!!URxvt.highlightColor" #A85C28
        #!!URxvt.highlightTextColor" #B5AF87
      };
    };
  };
}
