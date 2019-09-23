# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./services/base.nix
    ./services/zfs.nix
    ./services/power.nix
    ./services/xserver.nix
    ./modules/virtualization.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/home-manager.nix
    ./secret.nix
  ];

  networking.hostId = "0edeb995";
  networking.hostName = "nixos-desktop"; # Define your hostname.
}