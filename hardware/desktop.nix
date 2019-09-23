{ config, lib, pkgs, ... }: {
  imports = [
    ./base.nix
    ./base_desktop.nix
  ];

  boot.kernelParams = [
    "zswap.enabled=1"
  ];

  boot.kernel.sysctl = { "vm.swappiness" = 10; };
}