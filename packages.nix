{ config, pkgs, ... }:

{
  nix = {
    binaryCaches = [ "https://cache.nixos.org/" "https://dapp.cachix.org" ];
    binaryCachePublicKeys =
    [ "dapp.cachix.org-1:9GJt9Ja8IQwR7YW/aF0QvCa6OmjGmsKoZIist0dG+Rs=" ];
    trustedUsers = [ "root" "bscholtz" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        alsaSupport = true;
        pulseSupport = true;
      };
    };
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
  ];

  nixpkgs.config.firefox.enableAdobeFlash = false;
}
